class Game < ActiveRecord::Base
  belongs_to :bowler
  belongs_to :user
  belongs_to :squad_entry

  def to_s
  	"#{bowler} - #{score}"
  end
end
