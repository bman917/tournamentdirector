class Bowler < ActiveRecord::Base
  scope :by_gender, ->(gender) { where(gender: gender) unless (gender == 'A') }

  validates :name, presence: true
  validates_uniqueness_of :name
  belongs_to :bowling_association
  belongs_to :pbc_classification, class_name: 'BowlerClass', foreign_key: 'pbc_classification_id'
  has_and_belongs_to_many :squad_entries, autosave: true
  has_many :average_entries, :dependent => :delete_all
  has_many :games, :dependent => :delete_all
 
  attr_accessor :pbc_average

  def pbc_average
    if average_entries.any?
      average_entries.first.average 
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
    if search
      where('name LIKE ?' , "%#{search}%")
    else
      scoped
    end
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
    self.name
  end

  def get_tournament_entries(tournament)
    squad_entries.where(id: tournament.squad_entries)
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

end
