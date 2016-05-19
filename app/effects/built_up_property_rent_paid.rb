class BuiltUpPropertyRentPaid
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    property = game_state.board[player.location]
    owner = game_state.property_owner(property)
    houses = owner.houses[property.name]
    RentPaid.new(amount: property.house_rent[houses - 1]).apply(game_state)
  end
end
