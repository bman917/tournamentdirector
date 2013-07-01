class SquadEntry < ActiveRecord::Base
  has_and_belongs_to_many :bowlers
  has_many :games, :dependent => :delete_all
  belongs_to :squad

  def info
    "#{squad.info}-#{entry_type}-CLASS-#{category}"
  end

  def to_s
  	"ENTRY##{id} - #{entry_type}, Class #{category} - [#{bowler_names}]"
  end

  def title
    "Class #{category} #{entry_type} (#{bowler_names})"
  end

  def bowler_names
    bowlers.to_sentence
  end

  def total_pinfalls
    total = 0
    games.each { |game| total += game.score }
    total
  end
end
