class DiceRolledWhileNotInJail
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    if player.dice_rolls.size == 2
      rolled_a_double = player.dice_rolls.uniq.size == 1
      player.doubles_in_a_row += 1 if rolled_a_double
      return SentToJail.new.apply(game_state) if player.doubles_in_a_row == 3
      PlayerShifted.new.apply(game_state)
      game_state.expecting_rolls += 2 if rolled_a_double
    end
  end
end
