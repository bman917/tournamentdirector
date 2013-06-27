class CreateSquads < ActiveRecord::Migration
  def change
    create_table :squads do |t|
      t.string :name
      t.timestamp :time
      t.references :tournament, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
