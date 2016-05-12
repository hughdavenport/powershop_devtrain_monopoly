class DiceRoll < Event
  after_initialize :default_values
  store_accessor :data, :amount

  def apply(game_state)
    game_state.tap do |game_state|
      # TODO apply this...
    end
  end

  def can_apply?(game_state = game.state)
    game_state.started? && users_current_turn?(game_state)
  end

  def errors(game_state = game.state)
    ActiveModel::Errors.new(self).tap do |errors|
      errors.add(:base, :not_started) unless game_state.started?
      errors.add(:base, :not_current_turn) unless users_current_turn?(game_state)
    end
  end

  private

  def default_values
    self.amount = (Random.rand(6) + 1) unless amount.present?
  end

  def users_current_turn?(game_state = game.state)
    true # TODO decide on current turn
  end
end
