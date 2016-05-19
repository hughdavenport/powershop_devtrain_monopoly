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
    player.pay!(amount, owner)
  end

  private

  def set_amount(game_state, property)
    self.amount = game_state.details(property)[:rent]
  end

  attr_writer :amount
end
