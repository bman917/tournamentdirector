class SquadEntryGameForm

	def initialize(squad_entry)
		@squad_entry = squad_entry
	end

	def squad_entry
		@squad_entry
	end

	def bowlers
		@bowlers ||= @squad_entry.bowlers
	end

	def number_of_games
		@number_of_games ||= @squad_entry.game_type.number_of_games
	end

	def games
		@games = []

		(1..number_of_games).each do |i| 
	      g = Game.new(id: i)
	      puts "GAME ID #{g.id}"
	      @games << g
	    end
	    @games
	end

end