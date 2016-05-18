class SentToJail
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    game_state.send_player_to_jail!(player)
  end
end
