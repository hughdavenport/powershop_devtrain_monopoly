class TaxPaid
  attr_reader :amount

  def initialize(amount:)
    self.amount = amount
  end

  def apply(game_state)
    player = game_state.players[game_state.current_player]
    player[:money] -= amount
  end

  private

  attr_writer :amount
end
