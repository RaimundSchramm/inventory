json.array!(@games) do |game|
  json.extract! game, :name
  json.url game_url(game, format: :json)
end
