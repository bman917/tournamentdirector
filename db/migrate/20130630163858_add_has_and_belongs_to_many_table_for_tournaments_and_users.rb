class AddHasAndBelongsToManyTableForTournamentsAndUsers < ActiveRecord::Migration
  def change
  	create_table :tournaments_users, id: false do |t|
  		t.integer :tournament_id
  		t.integer :user_id
  	end
  end
end
