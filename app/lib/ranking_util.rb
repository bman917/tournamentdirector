module RankingUtil

	def self.total
		7777777
	end

	def self.get_ranking(tournament, category, game_type, limit)
		list = []
		processed_bowlers = []

		entries = tournament.squad_entries.where(category: category.name, game_type: game_type).limit(limit)
		entries.each do | e |
			unless processed_bowlers.include? e.bowlers
				list << e
				processed_bowlers << e.bowlers
			end
		end
		list
	end

end