class BondPaid < Event
  def apply(game_state)
    BondPosted.new.apply(game_state)
  end

  def can_apply?(game_state = game.state)
    player = game_state.players[game_state.current_player]
    game_state.expecting_rolls == 2 && player.can_afford?(50)
  end

  def errors(game_state = game.state)
    player = game_state.players[game_state.current_player]
    ActiveModel::Errors.new(self).tap do |errors|
      errors.add(:base, :already_rolled) unless game_state.expecting_rolls == 2
      errors.add(:base, :cannot_afford) unless player.can_afford?(50)
    end
  end
end
