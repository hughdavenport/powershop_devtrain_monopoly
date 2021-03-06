class PropertyPurchased < Event
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    property = game_state.board[player.location]
    game_state.purchase_property!(player, property)
  end

  def can_apply?(game_state = game.state)
    game_state.can_buy_property? && can_afford_property?(game_state)
  end

  def errors(game_state = game.state)
    ActiveModel::Errors.new(self).tap do |errors|
      errors.add(:base, :no_property_to_buy) unless game_state.can_buy_property?
      errors.add(:base, :not_enough_money) unless can_afford_property?(game_state)
    end
  end

  private

  def can_afford_property?(game_state = game.state)
    player = game_state.players[game_state.current_player]
    player.can_afford?(game_state.board[player.location].price)
  end
end
