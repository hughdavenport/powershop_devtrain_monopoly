module GamesHelper
  def current_game_player
    @game.players.find_by_user_id(@current_user.id)
  end

  def current_users_turn?
    true # TODO
  end

  def last_dice_roll
    current_game_player.dice_rolls.last
  end

  def last_dice_roll_p
    '<p id="diceroll">'.html_safe + "#{t('You rolled a '"#{last_dice_roll.amount}")}" + '</p>'.html_safe if current_users_turn? && last_dice_roll
  end
end
