class CardDrawn < Event
  store_accessor :data, :card

  def apply(game_state)
    # TODO make this more reliable
    self.card = game_state.cards.sample.name unless card.present?
    unless card == "No card"
      # TODO get card, apply it
      card_obj = game_state.cards.find_by_name(card)
      card_obj.effect.apply(game_state) if card_obj.respond_to?(:effect)
    end
    game_state.expecting_card_draw = false
  end

  def can_apply?(game_state = game.state)
    game_state.expecting_card_draw
  end

  def errors(game_state = game.state)
    ActiveModel::Errors.new(self).tap do |errors|
      errors.add(:base, :not_expecting_card_draw) unless game_state.expecting_card_draw
    end
  end
end
