class PlayerJoined < Event
  store_accessor :data, :piece
  store_accessor :data, :user

  def apply(gamestate)
    gamestate.tap do |gamestate|
      gamestate.players[user] = {
        piece: piece,
        money: 1500,
      }
    end
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
    !game_state.players.select { |user_id, data| data[:piece] == piece }.empty?
  end

  def user_already_joined?(game_state = game.state)
    game_state.players.include?(user)
  end
end
