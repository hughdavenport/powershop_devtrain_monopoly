class TurnEnded < Event
  def apply(game_state)
    game_state.tap do |game_state|
      game_state.players[game_state.current_player].tap do |player|
        game_state.end_turn!(player)
      end
    end
  end

  def can_apply?(game_state = game.state)
    game_state.expecting_rolls == 0
  end

  def errors(game_state = game.state)
    ActiveModel::Errors.new(self).tap do |errors|
      errors.add(:base, :expecting_roll) unless game_state.expecting_rolls == 0
    end
  end
end
