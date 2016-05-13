class PassGo < Event
  def apply(game_state)
    game_state.tap do |game_state|
      game_state.players[game_state.current_player].tap do |player|
        player[:money] += 200
      end
    end
  end
end
