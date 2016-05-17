class PayBond < Event
  store_accessor :data, :amount
  after_initialize :default_values

  def apply(game_state)
    player = game_state.players[game_state.current_player]
    player[:money] -= amount
    game_state.break_out_of_jail!(player)
  end

  private

  def default_values
    self.amount ||= 50
  end
end
