class AddHasAndBelongsToManyTableForBowlersAndSquadEntries < ActiveRecord::Migration
 def change
    create_table :bowlers_squad_entries, id: false do |t|
      t.integer :bowler_id
      t.integer :squad_entry_id
    end
  end
end
