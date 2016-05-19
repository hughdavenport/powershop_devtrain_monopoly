class BuiltUpPropertyRentPaid
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    property = game_state.board[player.location]
    owner = game_state.property_owner(property)
    amount = owner.hotels[property.name] ? property.hotel_rent : property.house_rent[owner.houses[property.name] - 1]
    RentPaid.new(amount: amount).apply(game_state)
  end
end
