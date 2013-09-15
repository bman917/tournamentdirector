class Squad < ActiveRecord::Base
  include PublicActivity::Common
  
  belongs_to :tournament
  belongs_to :user
  has_many :squad_entries

  def pending
  	squad_entries.where("games_count = 0")
  end

  def squad_entries_by_class(bowler_class)
    squad_entries.where(category: bowler_class.name)
  end

  def to_s
  	"SQUAD-#{name}"
  end

  def info
  	"#{tournament}-SQUAD-#{name}"
  end

   def record(action, user_doing_the_action)
    if action == :update
      description = "Updated Squad"
    elsif action == :destroy
      description = "Deleted Squad"
    elsif action == :create
      description = "Added Squad"
    end

    self.create_activity action, owner: user_doing_the_action, tournament_id: tournament.id, parameters: {description: description, details: to_s, tournament: tournament.name}
        
  end

end
