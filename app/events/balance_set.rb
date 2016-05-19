class BalanceSet < Event
  store_accessor :data, :amount

  def apply(game_state)
    player = game_state.players[game_state.current_player]
    player.set_balance!(amount.to_i)
  end
end
