class CreateBowlerClassesTournamentsTable < ActiveRecord::Migration
  def change
  	create_table :bowler_classes_tournaments, id: false do | t |
  		t.integer :bowler_class_id
  		t.integer :tournament_id
  	end
  end
end
