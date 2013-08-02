class AddSquadEntriesTotalPinfallsColumn < ActiveRecord::Migration
 
  def change
  	add_column :squad_entries, :total_pinfalls, :integer, default: 0
  end
  
end
