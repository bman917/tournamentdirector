class CreateSquadEntries < ActiveRecord::Migration
  def change
    create_table :squad_entries do |t|
      t.string :category
      t.string :entry_type
      t.references :squad, index: true

      t.timestamps
    end
  end
end
