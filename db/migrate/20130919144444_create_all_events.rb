class CreateAllEvents < ActiveRecord::Migration
  def change
    create_table :all_events do |t|
      t.references :tournament, index: true
      t.references :bowler, index: true
      t.integer :total_pinfalls
      t.references :bowler_class, index: true

      t.timestamps
    end
  end
end
