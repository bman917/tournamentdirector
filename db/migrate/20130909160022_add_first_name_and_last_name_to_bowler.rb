class AddFirstNameAndLastNameToBowler < ActiveRecord::Migration
  def change
  	add_column :bowlers, :last_name, :string, index: true
  	add_column :bowlers, :middle_name, :string, null: true
  end
end
