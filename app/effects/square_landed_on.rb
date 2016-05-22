class SquareLandedOn
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    square = game_state.board[player.location]
    square.effect.new.apply(game_state) if square.respond_to?(:effect)
  end
end
