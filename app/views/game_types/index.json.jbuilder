json.array!(@game_types) do |game_type|
  json.extract! game_type, :name, :number_of_players, :number_of_games
  json.url game_type_url(game_type, format: :json)
end