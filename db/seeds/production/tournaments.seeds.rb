Tournament.all.each  do |t|
  t.game_types.clear
  t.users.clear
end
Tournament.destroy_all
@sletba_open = Tournament.create(id: 1, name: 'SLETBA OPEN 2013', tournament_type: 'OPEN', start_date: "October 7, 2013", end_date: "October 14, 2013", bowling_association_id: 1)

@sletba_open.game_types << GameType.find('1')
@sletba_open.game_types << GameType.find('2')
@sletba_open.game_types << GameType.find('3')

@sletba_sept_monthly = Tournament.create(id: 2, name: 'SLETBA September 2013 Monthly Finals', tournament_type: 'MONTHLY', start_date: "September 29, 2013", end_date: "September 29, 2013", bowling_association_id: 1)
@sletba_sept_monthly.game_types << GameType.find('4')

open_squad = @sletba_sept_monthly.squads.create(name: 'OPEN Division', time: '2013-09-29 10:00')
class_a   = @sletba_sept_monthly.squads.create(name: 'CLASS A', time: '2013-09-29 13:00')
class_b_c = @sletba_sept_monthly.squads.create(name: 'CLASS B & C', time: '2013-09-29 15:00')

@sletba_open.users << User.find(1)
@sletba_open.users << User.find(5)
@sletba_open.users << User.find(7)
@sletba_open.users << User.find(3)


@sletba_open.bowler_classes << BowlerClass.where(id: [5,6,7,8,9])
