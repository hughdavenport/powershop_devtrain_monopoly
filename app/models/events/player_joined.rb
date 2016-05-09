class PlayerJoined < Event
  store_accessor :data, :piece
  store_accessor :data, :user

  def apply(gamestate)
    gamestate.dup.tap do |gamestate|
      gamestate.players[user] = {
        piece: piece,
        money: 1500,
      }
    end
  end

  def can_apply?(game_state = game.state)
    !(game_state.started? || piece_already_taken?(game_state) || user_already_joined?(game_state))
  end

  def errors
    ActiveModel::Errors.new(self).tap do |errors|
      errors.add(:base, :already_started) if game.state.started?
      errors.add(:base, :piece_already_taken) if piece_already_taken?
      errors.add(:base, :user_already_joined) if user_already_joined?
    end
  end

  private

  def piece_already_taken?(game_state = game.state)
    !game_state.players.select { |user_id, data| data[:piece] == piece }.empty?
  end

  def user_already_joined?(game_state = game.state)
    game_state.players.include?(user)
  end
end
