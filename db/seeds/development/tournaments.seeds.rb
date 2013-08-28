Tournament.all.each  do |t|
  t.game_types.clear
  t.users.clear
end
Tournament.delete_all
@sletba_open = Tournament.create(id: 1, name: 'SLETBA OPEN 2013', tournament_type: 'OPEN', start_date: "October 7, 2013", end_date: "October 14, 2013", bowling_association_id: 1)

@sletba_open.game_types << GameType.find('1')
@sletba_open.game_types << GameType.find('2')
@sletba_open.game_types << GameType.find('3')