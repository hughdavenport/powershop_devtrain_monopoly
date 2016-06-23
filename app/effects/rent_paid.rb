class RentPaid
  attr_reader :amount

  def initialize(amount: nil)
    self.amount = amount
  end

  def apply(game_state)
    player = game_state.players[game_state.current_player]
    # make a query object to just get what I need, rather than multiple calls like this
    property = game_state.board[player.location]
    set_amount(game_state, property) unless amount
    owner = game_state.property_owner(property)
    if player.can_afford?(amount)
      player.pay!(amount, owner)
    else
      PlayerBankrupted.new(owner: owner).apply(game_state)
    end
  end

  private

  def set_amount(game_state, property)
    self.amount = property.rent
  end

  attr_writer :amount
end
