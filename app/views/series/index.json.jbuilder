json.array!(@series) do |series|
  json.extract! series, :id, :name, :key_words, :user_id
  json.url series_url(series, format: :json)
end
