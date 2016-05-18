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
      apply_normal(game_state, player)
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

  def apply_normal(game_state, player)
    if player[:dice_rolls].size == 2
      rolled_a_double = player[:dice_rolls].uniq.size == 1
      player[:doubles_in_a_row] += 1 if rolled_a_double
      return SentToJail.new.apply(game_state) if player[:doubles_in_a_row] == 3
      PlayerShifted.new.apply(game_state)
      game_state.expecting_rolls += 2 if rolled_a_double
    end
  end
end
