class GoToJail < Event
  def apply(game_state)
    game_state.tap do |game_state|
      game_state.players[game_state.current_player].tap do |player|
        game_state.send_player_to_jail!(player)
      end
    end
  end
end
