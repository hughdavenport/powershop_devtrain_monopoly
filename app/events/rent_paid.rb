class RentPaid < Event
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    # make a query object to just get what I need, rather than multiple calls like this
    property = game_state.board[player[:location]]
    details = game_state.details(property)
    owner = game_state.property_owner(property)
    player[:money] -= details[:rent]
    owner[:money] += details[:rent]
  end
end
