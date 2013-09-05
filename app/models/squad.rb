class Squad < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :user
  has_many :squad_entries

  def pending
  	squad_entries.where("games_count = 0")
  end

  def to_s
  	"SQUAD-#{name}"
  end

  def info
  	"#{tournament}-SQUAD-#{name}"
  end

end
