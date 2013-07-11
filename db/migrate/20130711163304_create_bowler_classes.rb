class CreateBowlerClasses < ActiveRecord::Migration
  def change
    create_table :bowler_classes do |t|
      t.string :name
      t.references :bowlers, index: true

      t.timestamps
    end
  end
end
