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
BowlingAssociation.create(name: 'PBA')

GameType.delete_all
singles = GameType.create(id: 1, name: 'Singles', number_of_players: '1', number_of_games: '3')
doubles = GameType.create(id: 2, name: 'Doubles', number_of_players: '2', number_of_games: '2')
team    = GameType.create(id: 3, name: 'Team', number_of_players: '3', number_of_games: '2')

BowlerClass.delete_all
o = BowlerClass.create(name: 'OPEN')
a = BowlerClass.create(name: 'CLASS A')
b = BowlerClass.create(name: 'CLASS B')
c = BowlerClass.create(name: 'CLASS C')