class ChanceCardsShuffled < Event
  after_initialize :shuffle_cards
  store_accessor :data, :card_order

  def apply(game_state)
    game_state.chance_cards = card_order.map do |card_id|
      Card.find(card_id)
    end
  end

  def can_apply?(game_state = game.state)
    true
  end

  def errors(game_state = game.state)
    ActiveModel::Errors.new(self).tap do |errors|
    end
  end

  private

  def shuffle_cards
    self.card_order ||= Card.chance.shuffle.map { |card| card.id }
  end
end
