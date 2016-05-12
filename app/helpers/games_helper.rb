module GamesHelper
  def current_game_player
    @game_state.player(@current_user.id)
  end

  def current_users_turn?
    true # TODO
  end

  def last_dice_roll
    @game.dice_rolls.last
  end

  def last_dice_roll_p
    '<p id="dice_roll">'.html_safe + "#{'You rolled a '"#{last_dice_roll.amount}"}" + '</p>'.html_safe if current_users_turn? && last_dice_roll
  end

  def roll_dice_form
    form_tag(game_dice_rolls_path(@game)) do
      "".tap do |string|
        string << label_tag(:amount, "Dice roll")
        string << text_field_tag(:amount)# if Rails.env.test? || Rails.env.development?
        string << submit_tag('Roll Dice')
      end.html_safe
    end
  end
end
