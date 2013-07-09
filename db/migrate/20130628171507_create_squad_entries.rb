class CreateSquadEntries < ActiveRecord::Migration
  def change
    create_table :squad_entries do |t|
      t.string :category
      t.references :squad, index: true
      t.references :game_type, index: true

      t.timestamps
    end
  end
end
