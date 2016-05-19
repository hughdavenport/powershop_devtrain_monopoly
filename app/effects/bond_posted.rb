class BondPosted
  attr_reader :amount

  def initialize(amount: 50)
    self.amount = amount
  end

  def apply(game_state)
    player = game_state.players[game_state.current_player]
    player.pay!(amount)
    game_state.break_out_of_jail!(player)
  end

  private

  attr_writer :amount
end
