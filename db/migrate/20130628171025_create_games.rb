class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :score
      t.references :bowler, index: true
      t.string :notes
      t.references :user, index: true

      t.timestamps
    end
  end
end
