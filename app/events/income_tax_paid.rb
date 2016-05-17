class IncomeTaxPaid < TaxPaid
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    # TODO get 15% of player worth
    self.amount = [200].min
    super
  end
end
