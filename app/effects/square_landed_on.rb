class SquareLandedOn
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    square = game_state.board[player[:location]]
    details = game_state.details(square)
    details[:event].new.apply(game_state) if details.include?(:event)
  end
end
