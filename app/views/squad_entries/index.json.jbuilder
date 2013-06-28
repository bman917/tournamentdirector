json.array!(@squad_entries) do |squad_entry|
  json.extract! squad_entry, :category, :entry_type, :bowlers_id, :squad_id
  json.url squad_entry_url(squad_entry, format: :json)
end