class PayRent < Event
  def apply(game_state)
    game_state.tap do |game_state|
      game_state.players[game_state.current_player].tap do |player|
        property = game_state.board[player[:location]]
        details = game_state.details(property)
        owner = game_state.property_owner(property)
        player[:money] -= details[:rent]
        owner[:money] += details[:rent]
      end
    end
  end
end
