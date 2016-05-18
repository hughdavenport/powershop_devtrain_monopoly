class SuperTaxPaid
  def apply(game_state)
    TaxPaid.new(amount: 100).apply(game_state)
  end
end
