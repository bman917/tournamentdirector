class AddHasAndBelongsToManyTableForGameTypesAndTournaments < ActiveRecord::Migration
  def change
  	create_table :game_types_tournaments, id: false do |t|
  		t.integer :game_type_id
  		t.integer :tournament_id
  	end
  end
end
