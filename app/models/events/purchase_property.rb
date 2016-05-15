class PurchaseProperty < Event
  def apply(game_state)
    game_state.tap do |game_state|
      game_state.players[game_state.current_player].tap do |player|
        property = game_state.board[player[:location]]
        game_state.purchase_property!(player, property)
      end
    end
  end

  def can_apply?(game_state = game.state)
    game_state.can_buy_property?
    # TODO check balance of player
  end
end
