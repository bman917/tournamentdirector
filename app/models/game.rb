class Game < ActiveRecord::Base
  belongs_to :bowler
  belongs_to :user
  belongs_to :squad_entry
  validates :score, presence: true,  numericality: {greater_than_or_equal_to: 0.01}
  after_save :update_squad_entry_total

  def update_squad_entry_total
    squad_entry.update_total!
    squad_entry.save
  end

  def to_s
  	"#{bowler} - #{score}"
  end

  def notes_score
  	if notes
  		"#{notes} - #{score}"
  	else
  		score
  	end
  end
end
