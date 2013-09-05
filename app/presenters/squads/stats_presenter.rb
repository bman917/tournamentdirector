class Squads::StatsPresenter


	def initialize(squad)
		@squad = squad
	end

	def pending_size
		@pending_size ||= @squad.pending.size
	end

	def entries_size
		@entries_size ||= @squad.squad_entries.size
	end

	def bowler_classes
		@bowler_class ||= BowlerClass.all
	end

	def entries_by_category(bowler_class)
		@squad.squad_entries_by_class(bowler_class)
	end

end