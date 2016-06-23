class BondPosted
  attr_reader :amount

  def initialize(amount: 50)
    self.amount = amount
  end

  def apply(game_state)
    player = game_state.players[game_state.current_player]
    if player.can_afford?(amount)
      player.pay!(amount)
    else
      PlayerBankrupted.new.apply(game_state)
    end
    game_state.break_out_of_jail!(player)
  end

  private

  attr_writer :amount
end
