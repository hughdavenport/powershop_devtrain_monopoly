class UtilitiesRentPaid < RentPaid
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    property = game_state.board[player[:location]]
    owner = game_state.property_owner(property)
    utilities_owned = owner[:properties].select { |property| game_state.details(property)[:utility] }.count
    self.amount *= (utilities_owned == 1 ? 4 : 10)
    super
  end
end
