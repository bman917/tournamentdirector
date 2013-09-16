class SquadEntry < ActiveRecord::Base
  include PublicActivity::Common

#  scope :singles, find_by_game_type(GameType.first)
  default_scope { order("total_pinfalls DESC") }
  has_and_belongs_to_many :bowlers, autosave: true
  has_many :games, :dependent => :delete_all
  belongs_to :squad, :counter_cache => true
  belongs_to :game_type
  belongs_to :tournament
  validates :bowlers, :bowler_complete => true
  before_save :link_tournament

  def link_tournament
    self.tournament = squad.tournament if squad
  end



  def games_record_date
    games.first.created_at if has_games?
  end

  def games_recorded_by
    games.first.user if has_games?
  end

  def games_to_s
    games.map{ |g| g.score}

  end

  def zero_total
    puts "SquadEntry #{id} is Zeroing total"
    self.total_pinfalls = 0
    self.save!
  end

  def bowler_name
  end

  def update_total!
    self.total_pinfalls = games.sum("score") + games.sum("hdcp")
    self.save!
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
    s = "ENTRY - #{game_type} #{category} Division"
    s += ", #{bowler_names}, #{games.size} Games" if bowlers && bowlers.size > 0
    s
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

  def add_bowlers(bowlers)
    bowlers.each do | bowler |
      add_bowler(bowler)
    end
  end

  def add_bowler(bowler_name_or_id)

    bowler = Bowler.find_by_id(bowler_name_or_id)
    bowler ||= Bowler.find_by_name(bowler_name_or_id)

    unless bowler
      fname = bowler_name_or_id.split(' ').first if bowler_name_or_id
      @bowlers = Bowler.order(:name).where('name LIKE ?', "%#{fname}%")
      @bowlers.each do | b |
        bowler = b if b.full_name == bowler_name_or_id
      end
    end
    
    bowlers << bowler if bowler
  end

  def detail
    detail = self.title
    detail += " #{games.map{|g|g.score}.to_s}" if has_games?
    return detail
  end

  def record(action, user_doing_the_action)

    detail = self.detail

    if action == :update
      description = "Updated Squad Entry"
    elsif action == :destroy
      description = "Deleted Squad Entry"
    elsif action == :create
      description = "Added Squad Entry"
    elsif action == :create_game
      description = "Added Games"
    elsif action == :deleted_games
      description = "Deleted Games!"
    end

    self.create_activity action, owner: user_doing_the_action, tournament_id: tournament.id, parameters: {description: description, details: detail, tournament: tournament.name}
        
  end
end
