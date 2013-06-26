class AddBowlerGenderColumn < ActiveRecord::Migration
  def change
  	add_column :bowlers, :gender, :string, null: false, limit: 1, default: "M"
  end
end
