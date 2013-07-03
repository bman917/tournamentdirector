class SquadEntry < ActiveRecord::Base
  has_and_belongs_to_many :bowlers
  has_many :games, :dependent => :delete_all
  belongs_to :squad

  def info
    "#{squad.info}-#{entry_type}-CLASS-#{category}"
  end

  def to_s
  	"ENTRY##{id} - #{entry_type}, Class #{category}, #{bowler_names}, #{games.size} Games"
  end

  def title
    "Class #{category} #{entry_type} (#{bowler_names})"
  end

  def bowler_names
    bowlers.to_sentence
  end

  def total_pinfalls
    total = 0

    games.each { |game| total += game.score if game.score}
    total
  end

  def <=>(other)

    result = 0

    #Firstly, sort by category
    if category != other.category
      if category == 'O'
        result = -1
      elsif other.category == 'O'
        result = 1
      else
        result = category <=> other.category
      end
    end

    #Then, sort by entry type. 
    #Take advantage of fact that entry_type affects number of bowlers
    if result == 0
      result = bowlers.size <=> other.bowlers.size
    end

    #Finally, sort by total pinfalls
    if result == 0
      result = other.total_pinfalls <=> total_pinfalls 
    end
 
    return result
  end

  def isEntry?(param_entry_type)
    entry_type == param_entry_type
  end
  
end
