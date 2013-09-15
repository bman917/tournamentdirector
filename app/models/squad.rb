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

end
