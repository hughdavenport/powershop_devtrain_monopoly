class DiceRolledWhileInJail
  def apply(game_state)
    player = game_state.players[game_state.current_player]
    if player[:dice_rolls].size == 2
      return BrokeOutOfJail.new.apply(game_state) if player[:dice_rolls].uniq.size == 1
      player[:pairs_rolled_while_in_jail] += 1
      return BondPosted.new.apply(game_state) if player[:pairs_rolled_while_in_jail] == 3
    end
  end
end
