class ShiftPlayer < Event
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    old_location = player[:location]
    game_state.shift_player!(player)
    LandOnSquare.new.apply(game_state)
    PassGo.new.apply(game_state) if player[:location] < old_location
  end
end
