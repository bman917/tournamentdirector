json.array!(@games) do |game|
  json.extract! game, :score, :bowler_id, :notes, :user_id
  json.url game_url(game, format: :json)
end