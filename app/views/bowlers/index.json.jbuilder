json.array!(@bowlers) do |bowler|
  json.extract! bowler, :name, :bowling_association_id
  json.url bowler_url(bowler, format: :json)
end