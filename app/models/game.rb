class Game < ActiveRecord::Base
  belongs_to :bowler
  belongs_to :user
  belongs_to :squad_entry, :counter_cache => true
  validates :score, presence: true,  numericality: {only_integer:true, greater_than_or_equal_to: 0, less_than_or_equal_to: 300}
  after_save :update_squad_entry_total
  validates :bowler_id, presence: true

  def update_squad_entry_total
    if squad_entry
      #puts "Game (#{self}) is calling update_squad_entry_total of squad_entry: #{squad_entry.id}"
      squad_entry.update_total!
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
