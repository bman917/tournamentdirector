class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :tournament_type
      t.date :start_date
      t.date :end_date
      t.references :bowling_association, index: true

      t.timestamps
    end
  end
end
