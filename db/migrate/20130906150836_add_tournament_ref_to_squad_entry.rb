class AddTournamentRefToSquadEntry < ActiveRecord::Migration
  def change
    add_reference :squad_entries, :tournament, index: true

    puts "Linking SquadEntries to Tournaments"
    Tournament.all.each do | t |
	    t.squad_entries << SquadEntry.where(squad_id: t.squads);
	    puts "#{t} squad entries: #{t.squad_entries.size}"
	end
  end
end
