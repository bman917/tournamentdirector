class AddCounterColumnToSquads < ActiveRecord::Migration
  def change
  	add_column :squads, :squad_entries_count, :integer, :default => 0


  	Squad.reset_column_information
  	Squad.all.each do | squad |
  		Squad.update_counters squad.id, :squad_entries_count => squad.squad_entries.length
  	end

  end
end
