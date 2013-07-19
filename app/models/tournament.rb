class Tournament < ActiveRecord::Base
  belongs_to :bowling_association
  has_many :squads, dependent: :destroy
  has_and_belongs_to_many :users
  has_and_belongs_to_many :game_types, uniq: true


  def to_s
  	name
  end

  def squad_entries
  	squad_entries = Set.new
  	squads.each do | squad |
  		squad_entries += squad.squad_entries
  	end
  	squad_entries
  end

  def bowlers

  	bowlers = Set.new

  	self.squad_entries.each do | entry |
		entry.bowlers.each do | b|
			bowlers << b
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
  		entry.bowlers.each do | b|
			if b.bowling_association.id == bowling_association.id
				entries << entry
			end
			break
		end
  	end

  	entries
  end
end
