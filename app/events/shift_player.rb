class ShiftPlayer < Event
  def apply(game_state)
    game_state.tap do |game_state|
      game_state.players[game_state.current_player].tap do |player|
        old_location = player[:location]
        game_state.shift_player!(player)
        LandOnSquare.new.apply(game_state)
        PassGo.new.apply(game_state) if player[:location] < old_location
      end
    end
  end
end
