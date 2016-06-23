class TaxPaid
  attr_reader :amount

  def initialize(amount:)
    self.amount = amount
  end

  def apply(game_state)
    player = game_state.players[game_state.current_player]
    if player.can_afford?(amount)
      player.pay!(amount)
    else
      PlayerBankrupted.new.apply(game_state)
    end
  end

  private

  attr_writer :amount
end
