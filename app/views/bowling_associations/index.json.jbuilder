json.array!(@bowling_associations) do |bowling_association|
  json.extract! bowling_association, :name
  json.url bowling_association_url(bowling_association, format: :json)
end