class Bowler < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name
  belongs_to :bowling_association
  has_many :average_entries

  def latest_average

    if average_entries.last
    	average_entries.last.average
    else
    	"No Average Entry"
    end
  end

end
