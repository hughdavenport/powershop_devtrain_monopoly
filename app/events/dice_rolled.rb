class DiceRolled < Event
  after_initialize :default_values
  store_accessor :data, :amount

  def apply(game_state)
    player = game_state.players[game_state.current_player]
    player[:dice_rolls] << amount.to_i
    game_state.expecting_rolls -= 1
    if player[:in_jail]
      DiceRolledWhileInJail.new.apply(game_state)
    elsif player[:dice_rolls].size == 1 && game_state.expecting_rolls % 2 == 0
      DiceRolledForUtilityRent.new(dice_roll: player[:dice_rolls].pop).apply(game_state)
    else
      DiceRolledWhileNotInJail.new.apply(game_state)
    end
  end

  def can_apply?(game_state = game.state)
    game_state.started? && game_state.expecting_rolls > 0
  end

  def errors(game_state = game.state)
    ActiveModel::Errors.new(self).tap do |errors|
      errors.add(:base, :not_started) unless game_state.started?
      errors.add(:base, :not_expecting_roll) unless game_state.expecting_rolls > 0
    end
  end

  private

  def default_values
    self.amount = (Random.rand(6) + 1) unless amount.present?
  end
end
