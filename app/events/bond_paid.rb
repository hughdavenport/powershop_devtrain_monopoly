class BondPaid < Event
  def apply(game_state)
    BondPosted.new.apply(game_state)
  end

  def can_apply?(game_state = game.state)
    game_state.expecting_rolls == 2
  end

  def errors(game_state = game.state)
    ActiveModel::Errors.new(self).tap do |errors|
      errors.add(:base, :already_rolled) unless game_state.expecting_rolls == 2
    end
  end
end
