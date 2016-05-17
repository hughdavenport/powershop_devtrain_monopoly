class DiceRolled < Event
  after_initialize :default_values
  store_accessor :data, :amount

  def apply(game_state)
    # get rid of taps
    game_state.tap do |game_state|
      game_state.players[game_state.current_player].tap do |player|
        player[:dice_rolls] << amount.to_i
        if player[:in_jail]
          if player[:dice_rolls].size == 2
            return BreakOutOfJail.new.apply(game_state) if player[:dice_rolls].uniq.size == 1
            player[:pairs_rolled_while_in_jail] += 1
            return PayBond.new.apply(game_state) if player[:pairs_rolled_while_in_jail] == 3
          end
        else
          # Normal movement
          if player[:dice_rolls].size == 2
            rolled_a_double = player[:dice_rolls].uniq.size == 1
            player[:doubles_in_a_row] += 1 if rolled_a_double
            return GoToJail.new.apply(game_state) if player[:doubles_in_a_row] == 3
            ShiftPlayer.new.apply(game_state)
            game_state.expecting_rolls += 2 if rolled_a_double
          end
        end
        game_state.expecting_rolls -= 1
      end
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
