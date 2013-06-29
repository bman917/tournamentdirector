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

Bowler.delete_all
Bowler.create(id: 1, name: 'Jacky Chan', gender: 'M', bowling_association_id: 1)
Bowler.create(id: 2, name: 'Jeff Chan', gender: 'M', bowling_association_id: 1)
Bowler.create(id: 3, name: 'Peping Chan', gender: 'M', bowling_association_id: 1)
Bowler.create(id: 4, name: 'Pionie Chan', gender: 'M', bowling_association_id: 2)

User.delete_all
User.create(id: 1, email: 'bman917@yahoo.com', password: 'password', password_confirmation: 'password', role: 'ADMIN')

AverageEntry.delete_all
AverageEntry.create(average: 150, bowler_id: 1, user_id: 1)
AverageEntry.create(average: 200, bowler_id: 2, user_id: 1)
AverageEntry.create(average: 150, bowler_id: 3, user_id: 1)
AverageEntry.create(average:  70, bowler_id: 4, user_id: 1)

Tournament.delete_all
Tournament.create(id: 1, name: 'SLETBA OPEN 2013', tournament_type: 'OPEN', start_date: "October 7, 2013", end_date: "October 14, 2013", bowling_association_id: 1)

SquadEntry.delete_all