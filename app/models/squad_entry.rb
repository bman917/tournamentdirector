class SquadEntry < ActiveRecord::Base
  has_and_belongs_to_many :bowlers
  belongs_to :squad

  def to_s
  	"#{entry_type}, Class #{category} - [#{bowler_names}]"
  end

  def bowler_names
  	bowlers.to_sentence
  	
  end
end
