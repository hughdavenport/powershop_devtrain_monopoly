class StationRentPaid
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    property = game_state.board[player.location]
    owner = game_state.property_owner(property)
    stations_owned = owner.properties.select { |property| property.is_a?(StationProperty) }.count
    RentPaid.new(amount: 25 * (2 ** (stations_owned - 1))).apply(game_state)
  end
end
