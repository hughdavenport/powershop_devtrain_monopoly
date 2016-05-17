class OwnedUtilityLandedOn < Event
  def apply(game_state)
    game_state.expecting_rolls += 1
  end
end
