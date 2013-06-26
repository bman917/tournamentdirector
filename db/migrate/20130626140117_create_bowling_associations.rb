class CreateBowlingAssociations < ActiveRecord::Migration
  def change
    create_table :bowling_associations do |t|
      t.string :name

      t.timestamps
    end
  end
end
