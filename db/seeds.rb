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
Bowler.create(name: 'Jacky Chan', gender: 'M', bowling_association_id: 1)
Bowler.create(name: 'Jeff Chan', gender: 'M', bowling_association_id: 1)
Bowler.create(name: 'Peping Chan', gender: 'M', bowling_association_id: 1)
Bowler.create(name: 'Pionie Chan', gender: 'M', bowling_association_id: 2)

User.delete_all
User.create(id: 1, email: 'bman917@yahoo.com', password: 'password', password_confirmation: 'password', role: 'ADMIN')