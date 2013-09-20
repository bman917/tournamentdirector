class CreateAllEventsSquadEntriesTable < ActiveRecord::Migration
  def change
  	create_table :all_events_squad_entries, id: false do | t |
       t.integer :all_event_id
       t.integer :squad_entry_id
  	end
  end
end
