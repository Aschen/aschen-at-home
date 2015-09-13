json.array!(@wishes) do |wish|
  json.extract! wish, :id, :name, :price, :user_id
  json.url wish_url(wish, format: :json)
end
