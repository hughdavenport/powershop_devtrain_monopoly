json.array!(@players) do |player|
  json.extract! player, :id, :user_id, :piece
  json.url player_url(player, format: :json)
end
