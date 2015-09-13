json.array!(@episodes) do |episode|
  json.extract! episode, :id, :number, :watched, :downloaded, :season_id
  json.url episode_url(episode, format: :json)
end
