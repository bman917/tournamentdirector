class CreateGameTypes < ActiveRecord::Migration
  def change
    create_table :game_types do |t|
      t.string :name
      t.integer :number_of_players
      t.integer :number_of_games

      t.timestamps
    end
  end
end
