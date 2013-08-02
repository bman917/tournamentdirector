class Tournament < ActiveRecord::Base
  belongs_to :bowling_association
  has_many :squads, dependent: :destroy
  has_and_belongs_to_many :users
  has_and_belongs_to_many :game_types, -> { uniq }


  def to_s
  	name
  end

  def squad_entriesx(game_type, category)
    SquadEntry.where(squad_id: squads, game_type: game_type, category: category).where("total_pinfalls > 0")
  end

  def squad_entries
      SquadEntry.where(squad_id: squads)
  end

  def bowlers (bowling_association=nil)

  	bowlers = Set.new

  	self.squad_entries.each do | entry |
		entry.bowlers.each do | b|
      bowlers << b if bowling_association == nil || bowling_association == b.bowling_association
		end
  	end

  	return bowlers
  end

  def participating_associations

  	bowling_association = Set.new
  	self.bowlers.each do | bowler |
  		bowling_association << bowler.bowling_association
  	end
    
	bowling_association
  end

  def bowling_association_entries(bowling_association)

  	entries = Set.new
  	self.squad_entries.each do | entry |
  		if entry.belongs_to_bowling_association?(bowling_association)
				entries << entry
			end
		end
  	entries
  end
end
