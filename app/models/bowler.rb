class Bowler < ActiveRecord::Base
  scope :by_gender, ->(gender) { where(gender: gender) unless (gender == 'A') }

  validates :name, presence: true
  validates_uniqueness_of :name
  belongs_to :bowling_association
  belongs_to :pbc_classification, class_name: 'BowlerClass', foreign_key: 'pbc_classification_id'
  has_and_belongs_to_many :squad_entries
  has_many :average_entries
  has_many :games

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

  def to_s
    self.name
  end

  def get_tournament_entries(tournament)
    squad_entries.where(id: tournament.squad_entries)
  end





end
