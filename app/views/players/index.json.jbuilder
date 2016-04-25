json.array!(@players) do |player|
  json.extract! player, :id, :user_id, :game_id
  json.url player_url(player, format: :json)
end
