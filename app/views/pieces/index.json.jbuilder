json.array!(@pieces) do |piece|
  json.extract! piece, :id, :player_id, :name
  json.url piece_url(piece, format: :json)
end
