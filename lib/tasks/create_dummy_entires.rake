namespace :tournament do
	desc "Create a squad entry for each bowler"
	task :dummy_data => :environment do

		SquadEntry.destroy_all


		singles = GameType.find(1)

		bowlers = Bowler.where('id in (select bowler_id from average_entries where average > 185)')
		puts "Bowlers #{bowlers.size}"

		squad = Tournament.first.squads.first

		open_masters = BowlerClass.find(5).name
		graded = BowlerClass.find(6).name
		associate = BowlerClass.find(7).name

		bowlers.each do | bowler |
			entry = squad.squad_entries.create(game_type_id: 1, category: open_masters)
			entry.bowlers << bowler
			entry.save!
			puts "Created #{entry}"
	    end

		graded_bowlers = Bowler.where('id in (select bowler_id from average_entries where average > 175 and average < 190)')
		puts "Bowlers #{bowlers.size}"

		graded_bowlers.each do | bowler |
			entry = squad.squad_entries.create(game_type_id: 1, category: graded)
			entry.bowlers << bowler
			entry.save!
			puts "Created #{entry}"
	    end

		associate_bowlers = Bowler.where('id in (select bowler_id from average_entries where average > 165 and average < 180)')
		puts "Bowlers #{bowlers.size}"

		associate_bowlers.each do | bowler |
			entry = squad.squad_entries.create(game_type_id: 1, category: associate)
			entry.bowlers << bowler
			entry.save!
			puts "Created #{entry}"
	    end

	end
end
