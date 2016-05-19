class PlayerJoined < Event
  store_accessor :data, :piece
  store_accessor :data, :user

  def apply(game_state)
    game_state.players << Player.new(user: user, piece: piece)
    game_state.current_player = 0 if game_state.current_player.nil?
  end

  def can_apply?(game_state = game.state)
    piece_valid? && !(game_state.started? || piece_already_taken?(game_state) || user_already_joined?(game_state))
  end

  def errors(game_state = game.state)
    ActiveModel::Errors.new(self).tap do |errors|
      errors.add(:base, :piece_invalid) unless piece_valid?
      errors.add(:base, :already_started) if game_state.started?
      errors.add(:base, :piece_already_taken) if piece_already_taken?(game_state)
      errors.add(:base, :user_already_joined) if user_already_joined?(game_state)
    end
  end

  private

  def piece_valid?
    GameState::PIECES.include?(piece.to_sym)
  end

  def piece_already_taken?(game_state = game.state)
    !game_state.player_with_piece(piece).nil?
  end

  def user_already_joined?(game_state = game.state)
    !game_state.player(user).nil?
  end
end
