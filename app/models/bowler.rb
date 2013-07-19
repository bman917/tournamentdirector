class Bowler < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name
  belongs_to :bowling_association
  has_and_belongs_to_many :squad_entries
  has_many :average_entries
  has_many :games

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

    tournament_entries = []
     squad_entries.each do | entry |
        tournament_entries << entry if entry.belongs_to_tournament?(tournament)
    end
    tournament_entries
    
  end



end
