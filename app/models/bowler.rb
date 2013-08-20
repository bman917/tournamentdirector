class Bowler < ActiveRecord::Base
  scope :by_gender, ->(gender) { where(gender: gender) unless (gender == 'A') }

  validates :name, presence: true
  validates_uniqueness_of :name
  belongs_to :bowling_association
  has_and_belongs_to_many :squad_entries
  has_many :average_entries
  has_many :games

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
