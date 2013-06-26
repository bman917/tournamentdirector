class CreateBowlers < ActiveRecord::Migration
  def change
    create_table :bowlers do |t|
      t.string :name
      t.references :bowling_association, index: true

      t.timestamps
    end
  end
end
