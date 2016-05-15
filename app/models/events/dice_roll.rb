class DiceRoll < Event
  after_initialize :default_values
  store_accessor :data, :amount

  def apply(game_state)
    game_state.tap do |game_state|
      game_state.players[game_state.current_player].tap do |player|
        player[:dice_rolls] << amount.to_i
        if player[:in_jail]
          if player[:dice_rolls].size == 2
            return BreakOutOfJail.new.apply(game_state) if player[:dice_rolls].uniq.size == 1
            player[:pairs_rolled_while_in_jail] += 1
            return PayBond.new.apply(game_state) if player[:pairs_rolled_while_in_jail] == 3
            game_state.end_turn!(player)
          end
        else
          # Normal movement
          if player[:dice_rolls].size == 2
            rolled_a_double = player[:dice_rolls].uniq.size == 1
            player[:doubles_in_a_row] += 1 if rolled_a_double
            return GoToJail.new.apply(game_state) if player[:doubles_in_a_row] == 3
            old_location = player[:location]
            game_state.shift_player!(player)
            LandOnSquare.new.apply(game_state)
            PassGo.new.apply(game_state) if player[:location] < old_location
            game_state.end_turn!(player) unless game_state.action_required? || rolled_a_double
          end
        end
      end
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
    # This needs to check whether current_player can actuall roll, and change method name
    true
  end
end
