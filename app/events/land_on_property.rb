class LandOnProperty < Event
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    property = game_state.board[player[:location]]
    owner = game_state.property_owner(property)
    if owner.nil?
      game_state.can_buy_property = true
    elsif owner != player
      PayRent.new.apply(game_state)
    end
  end
end
