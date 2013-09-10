class AddAverageTypeToAverageEntry < ActiveRecord::Migration
  def change
  	add_column :average_entries, :average_type, :string
  end
end
