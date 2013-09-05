class AddCounterColumnToSquadEntries < ActiveRecord::Migration
  def change
  	add_column :squad_entries, :games_count, :integer, :default => 0

  	SquadEntry.reset_column_information
  	SquadEntry.all.each do | se |
  		SquadEntry.update_counters se.id, :games_count => se.games.length
  	end


  end
end
