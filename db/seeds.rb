# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
BowlingAssociation.delete_all
BowlingAssociation.create(id: 1, name: 'SLETBA')
BowlingAssociation.create(id: 2, name: 'TBAM')
BowlingAssociation.create(name: 'MTBA')
BowlingAssociation.create(name: 'PBC')

o = BowlerClass.create(name: 'OPEN')
a = BowlerClass.create(name: 'CLASS A')
b = BowlerClass.create(name: 'CLASS B')
c = BowlerClass.create(name: 'CLASS C')

Bowler.delete_all
jacky  = Bowler.create(id: 1, name: 'Jacky Chan', gender: 'M', bowling_association_id: 1)
jeff   = Bowler.create(id: 2, name: 'Jeff Chan', gender: 'M', bowling_association_id: 1)
peping = Bowler.create(id: 3, name: 'Peping Chan', gender: 'M', bowling_association_id: 1)
pionie = Bowler.create(id: 4, name: 'Pionie Chan', gender: 'M', bowling_association_id: 2)

AverageEntry.delete_all
AverageEntry.create(average: 150, bowler_id: 1, user_id: 1)
AverageEntry.create(average: 200, bowler_id: 2, user_id: 1)
AverageEntry.create(average: 150, bowler_id: 3, user_id: 1)
AverageEntry.create(average:  70, bowler_id: 4, user_id: 1)


SquadEntry.delete_all

GameType.delete_all
singles = GameType.create(id: 1, name: 'Singles', number_of_players: '1', number_of_games: '3')
doubles = GameType.create(id: 2, name: 'Doubles', number_of_players: '2', number_of_games: '2')
team    = GameType.create(id: 3, name: 'Team', number_of_players: '3', number_of_games: '2')

Squad.delete_all

Tournament.all.each  do |t|
  t.game_types.clear
  t.users.clear
end
Tournament.delete_all
sletba_open = Tournament.create(id: 1, name: 'SLETBA OPEN 2013', tournament_type: 'OPEN', start_date: "October 7, 2013", end_date: "October 14, 2013", bowling_association_id: 1)

sletba_open.game_types << GameType.find('1')
sletba_open.game_types << GameType.find('2')
sletba_open.game_types << GameType.find('3')

User.delete_all
User.create(id: 1, email: 'bman917@yahoo.com', password: 'password', role: 'MASTER')
User.create(id: 3, email: 'admin',             password: 'admin', role: 'ADMIN')
User.create(id: 4, email: 'pepichan@yahoo.com',password: 'password', role: 'ADMIN')

User.find(3).tournaments << sletba_open
User.find(4).tournaments << sletba_open


Squad.destroy_all
squad1 = Squad.create(name: "1", time: Time.now, tournament_id: 1, user_id: 1)

ActiveRecord::Base.connection.execute("delete from bowlers_squad_entries");

BowlerClass.delete_all
o = BowlerClass.create(name: 'OPEN').name
a = BowlerClass.create(name: 'CLASS A').name
b = BowlerClass.create(name: 'CLASS B').name
c = BowlerClass.create(name: 'CLASS C').name


e = SquadEntry.create(squad: squad1, game_type: singles, category: o).bowlers << jacky
e = SquadEntry.create(squad: squad1, game_type: singles, category: o).bowlers << jeff
e = SquadEntry.create(squad: squad1, game_type: singles, category: o).bowlers << peping
e = SquadEntry.create(squad: squad1, game_type: singles, category: o).bowlers << pionie

e = SquadEntry.create(squad: squad1, game_type: singles, category: a).bowlers << jacky
e = SquadEntry.create(squad: squad1, game_type: singles, category: a).bowlers << jeff
e = SquadEntry.create(squad: squad1, game_type: singles, category: a).bowlers << peping
e = SquadEntry.create(squad: squad1, game_type: singles, category: a).bowlers << pionie

e = SquadEntry.create(squad: squad1, game_type: singles, category: b).bowlers << jacky
e = SquadEntry.create(squad: squad1, game_type: singles, category: b).bowlers << jeff
e = SquadEntry.create(squad: squad1, game_type: singles, category: b).bowlers << peping
e = SquadEntry.create(squad: squad1, game_type: singles, category: b).bowlers << pionie

e = SquadEntry.create(squad: squad1, game_type: singles, category: c).bowlers << jacky
e = SquadEntry.create(squad: squad1, game_type: singles, category: c).bowlers << jeff
e = SquadEntry.create(squad: squad1, game_type: singles, category: c).bowlers << peping
e = SquadEntry.create(squad: squad1, game_type: singles, category: c).bowlers << pionie



