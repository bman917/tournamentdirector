
load "#{Rails.root}/db/seeds.rb"

Tournament.all.each  do |t|
  t.game_types.clear
  t.users.clear
end
Tournament.delete_all
@sletba_open = Tournament.create(id: 1, name: 'SLETBA OPEN 2013', tournament_type: 'OPEN', start_date: "October 7, 2013", end_date: "October 14, 2013", bowling_association_id: 1)

@sletba_open.game_types << GameType.find('1')
@sletba_open.game_types << GameType.find('2')
@sletba_open.game_types << GameType.find('3')

Bowler.delete_all
Squad.destroy_all
SquadEntry.destroy_all

#
# puts "Creating Bowlers...."
#
juan   = Bowler.create(id: 1, name: 'Juan',   last_name: 'Dela Cruz', gender: 'M', bowling_association_id: 1)
jacky  = Bowler.create(id: 2, name: 'Jacky',  last_name: 'Chan', gender: 'M', bowling_association_id: 1)
jeff   = Bowler.create(id: 3, name: 'Jeff',   last_name: 'Chan', gender: 'M', bowling_association_id: 1)
peping = Bowler.create(id: 4, name: 'Peping', last_name: 'Chan', gender: 'M', bowling_association_id: 1)
pionie = Bowler.create(id: 5, name: 'Pionie', last_name: 'Chan', gender: 'M', bowling_association_id: 2)

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

(3..4).each do | i |

	squad_entry = squad1.squad_entries.create(id: i, game_type_id: 1, category: 'OPEN')
	squad_entry.bowlers << pionie
	squad_entry.save!


	(0..squad_entry.game_type.number_of_games).each do
		squad_entry.games.create(bowler: pionie, score: (110 + i))
	end
end

(5..6).each do | i |

	squad_entry = squad1.squad_entries.create(id: i, game_type_id: 1, category: 'OPEN')
	squad_entry.bowlers << jacky
	squad_entry.save!


	(0..squad_entry.game_type.number_of_games).each do
		squad_entry.games.create(bowler: jacky, score: (70 + i))
	end
end
