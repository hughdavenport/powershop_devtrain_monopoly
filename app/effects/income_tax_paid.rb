class IncomeTaxPaid
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    # TODO get 15% of player worth
    TaxPaid.new(amount: [200].min).apply(game_state)
  end
end
