json.array!(@squads) do |squad|
  json.extract! squad, :name, :time, :tournament_id, :user_id
  json.url squad_url(squad, format: :json)
end