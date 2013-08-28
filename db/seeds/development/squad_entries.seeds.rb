after "development:bowlers, development:tournaments" do


  Squad.destroy_all
  squad1 = Squad.create(name: "1", time: Time.now, tournament_id: 1, user_id: 1)

  ActiveRecord::Base.connection.execute("delete from bowlers_squad_entries");

  SquadEntry.destroy_all

  singles = GameType.find_by_name('Singles')
  o = BowlerClass.find_by_name('OPEN').name
  a = BowlerClass.find_by_name('CLASS A').name
  b = BowlerClass.find_by_name('CLASS B').name
  c = BowlerClass.find_by_name('CLASS C').name

  Bowler.all[1..50].each do | bowlerx |
  	e = SquadEntry.create(squad: squad1, game_type: singles, category: o).bowlers << bowlerx
  end

  Bowler.all[50..100].each do | bowlerx |
  	e = SquadEntry.create(squad: squad1, game_type: singles, category: a).bowlers << bowlerx
  end

  Bowler.all[100..150].each do | bowlerx |
  	e = SquadEntry.create(squad: squad1, game_type: singles, category: b).bowlers << bowlerx
  end

end