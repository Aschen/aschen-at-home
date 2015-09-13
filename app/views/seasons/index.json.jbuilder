json.array!(@seasons) do |season|
  json.extract! season, :id, :number, :episodes_count, :auto_download, :series_id
  json.url season_url(season, format: :json)
end
