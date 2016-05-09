module GamesHelper
  def current_game_player
    @game_state.players[@current_user.id]
  end

  def current_users_turn?
    true # TODO
  end

  def last_dice_roll
    @game.dice_rolls.last
  end

  def last_dice_roll_p
    '<p id="diceroll">'.html_safe + "#{t('You rolled a '"#{last_dice_roll.amount}")}" + '</p>'.html_safe if current_users_turn? && last_dice_roll
  end

  def roll_dice_form
    form_tag(game_dice_rolls_path(@game)) do
      submit_tag('Roll Dice')
    end
  end
end
