class HotelPurchased < Event
  store_accessor :data, :property

  def apply(game_state)
    player = game_state.players[game_state.current_player]
    player.purchase_hotel!(property)
  end

  def can_apply?(game_state = game.state)
    player = game_state.players[game_state.current_player]
    game_state.expecting_rolls == 2 && player.can_buy_hotel?(property) && player.can_afford?(ColouredProperty.find_by_name(property).building_price)
  end

  def errors(game_state = game.state)
    player = game_state.players[game_state.current_player]
    ActiveModel::Errors.new(self).tap do |errors|
      errors.add(:base, :already_rolled) unless game_state.expecting_rolls == 2
      errors.add(:base, :cannot_buy_hotel_on_property) unless player.can_buy_hotel?(property)
      errors.add(:base, :not_enough_money) unless player.can_afford?(ColouredProperty.find_by_name(property).building_price)
    end
  end
end
