class Squads::ShowPresenter 

	def initialize(squad)
	  @squad = squad
	end

	def squad_entries
		@squad_entries ||= @squad.squad_entries.includes(:game_type).includes(:bowlers).includes(:games)
	end

	def bowler_classes
		@bowler_class ||= @squad.tournament.bowler_classes
	end

	def game_types
		@game_types ||= @squad.tournament.game_types
	end
end