class Bowler < ActiveRecord::Base
  include PublicActivity::Common
  scope :by_gender, ->(gender) { where(gender: gender) unless (gender == 'A') }

  validates :name, :last_name, presence: true
# validates :full_name, uniqueness: true
  belongs_to :bowling_association
  belongs_to :pbc_classification, class_name: 'BowlerClass', foreign_key: 'pbc_classification_id'
  has_and_belongs_to_many :squad_entries, autosave: true
  has_many :average_entries, :dependent => :delete_all
  has_many :games, :dependent => :delete_all
  has_many :all_events

  validate :full_name_cannot_have_duplicates

  attr_accessor :pbc_average

  def full_name_cannot_have_duplicates
    if created_at == updated_at
      result = Bowler.where('name = ? and last_name = ? and id != ?', name, last_name, id)
      unless result.blank?
        errors[:full_name] << "#{full_name} has already been taken by bowler id #{result.first.id}. Duplicate Bowler full name is not allowed."
      end
    end
  end

  def full_name_with_ave
    "#{name} #{middle_name} #{last_name} [ave #{pbc_average}]".squeeze(' ')
  end

  def cached_full_name_with_ave
    Rails.cache.fetch([self,"full_name"]) { full_name_with_ave }
  end

  def full_name
    "#{name} #{middle_name} #{last_name}".squeeze(' ')
  end

  def pbc_average
    if average_entries.any?
      average_entries.last.average 
    else
      "No PBC Average"
    end
  end

  def update_pbc_classification
    self.pbc_classification = BowlerClass.find_by_name('OPEN') if latest_average > 180
    self.pbc_classification = BowlerClass.find_by_name('CLASS A') if latest_average <= 180
    self.pbc_classification = BowlerClass.find_by_name('CLASS B') if latest_average <= 160
    self.pbc_classification = BowlerClass.find_by_name('CLASS C') if latest_average <= 140
    save
  end

  def self.search(search)
    result = all
    if search
      search.squeeze(' ').split(' ').each do | term |
        result = result.where('name LIKE ? or last_name LIKE ?' , "%#{term}%", "%#{term}%")
      end
    end

    result
  end

  def latest_average

    if average_entries.last
    	average_entries.last.average
    else
    	"No Average Entry"
    end
  end

  def name_css
      self.name.delete(' ')
  end

  def to_s
    self.full_name
  end

  def get_tournament_all_event_entry(tournament)
    self.all_events.where(id: tournament.all_events).first if tournament
  end

  def get_tournament_entries(tournament)
    if self.squad_entries && self.squad_entries.size > 0 && tournament
      self.squad_entries.where(id: tournament.squad_entries)
    end
  end

  def games_in_tournament(tournament=nil)
    if tournament
      @games ||= games.where(squad_entry_id: squad_entries.where(id: tournament.squad_entries))
    else
      @games = self.games
    end
    @games
  end

  def average(tournament)
    games_in_tournament(tournament).average(:score).to_i
  end

  def details
    "[ID-#{id}] #{full_name}, Ave:#{latest_average}, #{pbc_classification}"
  end

  def record(action, user_doing_the_action, tournament)

    detail = self.details

    if action == :update
      description = "Updated Bowler"
    elsif action == :destroy
      description = "Deleted Bowler"
    elsif action == :create
      description = "Added Bowler"
    elsif action == :update_average
      description = "Updated Average"
    end

    self.create_activity action, owner: user_doing_the_action, tournament_id: tournament.id, parameters: {description: description, details: detail, tournament: tournament.name}
        
  end

end
