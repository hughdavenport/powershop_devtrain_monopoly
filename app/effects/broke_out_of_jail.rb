class BrokeOutOfJail
  def apply(game_state)
    BondPosted.new(amount: 0).apply(game_state)
  end
end
