class AddGenderColumnToGameType < ActiveRecord::Migration

 def change
  	add_column :game_types, :gender, :string, default: 'A'
 end

end
