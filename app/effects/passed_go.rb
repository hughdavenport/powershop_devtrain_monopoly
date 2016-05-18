class PassedGo
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    player[:money] += 200
  end
end
