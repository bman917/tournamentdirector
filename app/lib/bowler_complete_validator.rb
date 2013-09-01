class BowlerCompleteValidator < ActiveModel::EachValidator

	def validate_each(squad_entry, bowlers, bowler_ids)
	    unless squad_entry.game_type.number_of_players == bowler_ids.size
	    	squad_entry.errors[bowlers] << (options[:message] || "has incorrect number of players")
	    end
  	end
end