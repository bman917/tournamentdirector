class SquadEntry < ActiveRecord::Base
#  scope :singles, find_by_game_type(GameType.first)
  default_scope order("total_pinfalls DESC")
  has_and_belongs_to_many :bowlers
  has_many :games, :dependent => :delete_all
  belongs_to :squad
  belongs_to :game_type

  def update_total!
    self.total_pinfalls = games.sum("score")
  end

  def belongs_to_tournament?(tournament)
    squad.tournament.id == tournament.id
  end

  def belongs_to_bowling_association?(bowling_association)
    result = false
    bowlers.each do | bowler |
      result = true if bowler.bowling_association == bowling_association
    end
    return result
  end

  def category_css
    s = String.new(category)
    s.gsub!(/\s+/, "")
    s
  end


  def has_games?
    games && games.size > 0
  end

  def games_recorded
    if games && games.size > 0
      games.size / bowlers.size
    else
      0
    end
  end

  def games_of_bowler(id)
    @games = games.where(bowler_id: id)
  end


  def info
    "#{squad.info}-#{game_type}-#{category}"
  end

  def to_s
  	"ENTRY - #{game_type} #{category} Division, #{bowler_names}, #{games.size} Games"
  end

  def title
    "#{category} #{game_type} (#{bowler_names})"
  end

  def bowler_names
    bowlers.to_sentence
  end

  def <=>(other)

    result = 0

    #Firstly, sort by category
    if category != other.category
      if category == 'OPEN'
        result = -1
      elsif other.category == 'OPEN'
        result = 1
      else
        result = category <=> other.category
      end
    end

    #Then, sort by entry type. 
    #Take advantage of fact that game_type affects number of bowlers
    if result == 0
      result = bowlers.size <=> other.bowlers.size
    end

    #Finally, sort by total pinfalls
    if result == 0
      result = other.total_pinfalls <=> total_pinfalls 
    end
 
    return result
  end

  def isEntry?(param_game_type)
    game_type == param_game_type
  end

end
