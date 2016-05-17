class PayTax < Event
  store_accessor :data, :amount

  def apply(game_state)
    player = game_state.players[game_state.current_player]
    player[:money] -= amount
  end
end
