class AddGenderToBowlerClass < ActiveRecord::Migration
  def change
    add_column :bowler_classes, :gender, :string, default: "A"
  end
end
