class Game < ActiveRecord::Base
  belongs_to :bowler
  belongs_to :user
  belongs_to :squad_entry
  validates :score, presence: true,  numericality: {only_integer:true, greater_than_or_equal_to: 0, less_than_or_equal_to: 300}
  after_save :update_squad_entry_total
  validates :bowler_id, presence: true

  def update_squad_entry_total
    if squad_entry
      squad_entry.update_total!
      squad_entry.save
    end
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
