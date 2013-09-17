class Squads::ShowPresenter 

	def initialize(squad, page)
	  @squad = squad
	  @page = page
	end

	def squad_entries
		@squad_entries ||= @squad.cached_squad_entries
	end

	def bowler_classes
		@bowler_class ||= @squad.tournament.bowler_classes
	end

	def game_types
		@game_types ||= @squad.tournament.game_types
	end
end