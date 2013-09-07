Bowler.delete_all
Squad.destroy_all
SquadEntry.destroy_all

#
# puts "Creating Bowlers...."
#
juan   = Bowler.create(id: 1, name: 'Juan Dela Cruz', gender: 'M', bowling_association_id: 1)
jacky  = Bowler.create(id: 2, name: 'Jacky Chan', gender: 'M', bowling_association_id: 1)
jeff   = Bowler.create(id: 3, name: 'Jeff Chan', gender: 'M', bowling_association_id: 1)
peping = Bowler.create(id: 4, name: 'Peping Chan', gender: 'M', bowling_association_id: 1)
pionie = Bowler.create(id: 5, name: 'Pionie Chan', gender: 'M', bowling_association_id: 2)

#
#puts "Creating Squad 1..."
#
squad1 = Squad.create(id: 1, name: "1", time: Time.now, tournament_id: 1, user_id: 1)


#
#puts "Creating Entries for Squad 1"
#

(1..2).each do | i |

	squad_entry = squad1.squad_entries.create(id: i, game_type_id: 1, category: 'OPEN')
	squad_entry.bowlers << juan
	squad_entry.save!

	(0..squad_entry.game_type.number_of_games).each do
		squad_entry.games.create(bowler: juan, score: (100 + i))
	end
end




