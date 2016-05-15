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

  def buy_property_form
    form_tag(game_buy_properties_path(@game)) do
      "".tap do |string|
        string << submit_tag('Buy property')
      end.html_safe
    end
  end

  def owned_properties
    content_tag(:div, id: "owned_properties") do
      "".tap do |string|
        string << content_tag(:strong, "Owned properties")
        @game_state.owned_properties.each do |user, properties|
          string << content_tag(:div, id: ("my_properties" if user == @current_user.id)) do
            "".tap do |string|
              string << content_tag(:h5, User.find(user).username)
              properties.each do |property|
                string << content_tag(:div, t(property))
              end
            end.html_safe
          end
        end
      end.html_safe
    end
  end
end
