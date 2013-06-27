json.array!(@average_entries) do |average_entry|
  json.extract! average_entry, :average, :bowler_id, :user_id, :record_date
  json.url average_entry_url(average_entry, format: :json)
end