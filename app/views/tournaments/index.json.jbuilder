json.array!(@tournaments) do |tournament|
  json.extract! tournament, :name, :start_date, :end_date, :bowling_association_id
  json.url tournament_url(tournament, format: :json)
end