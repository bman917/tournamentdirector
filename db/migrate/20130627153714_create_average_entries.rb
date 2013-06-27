class CreateAverageEntries < ActiveRecord::Migration
  def change
    create_table :average_entries do |t|
      t.integer :average
      t.references :bowler, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
