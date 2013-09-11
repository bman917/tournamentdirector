class AddAverageTypeToAverageEntry < ActiveRecord::Migration
  def change
  	add_column :average_entries, :average_type, :string
  	add_column :average_entries, :total_pinfalls, :integer
  	add_column :average_entries, :games_played, :integer
  end
end
