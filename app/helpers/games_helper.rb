module GamesHelper
  def testing_mode?
    Rails.env.development? || Rails.env.test?
  end

  def current_game_player
    @game_state.player(@current_user.id)
  end

  def current_users_turn?
    true # TODO
  end

  def last_dice_roll
    @game.dice_rolleds.last
  end

  def last_dice_roll_p
    '<p id="last_dice_roll">'.html_safe + "#{'You rolled a '"#{last_dice_roll.amount}"}" + '</p>'.html_safe if current_users_turn? && last_dice_roll
  end

  def set_balance_form
    form_tag(game_set_balances_path(@game)) do
      "".tap do |string|
        if testing_mode?
          string << label_tag(:amount, "Balance")
          string << text_field_tag(:amount)
        end
        string << submit_tag('Set balance')
      end.html_safe
    end
  end

  def roll_dice_form
    form_tag(game_dice_rolls_path(@game)) do
      "".tap do |string|
        if testing_mode?
          string << label_tag(:amount, "Dice roll")
          string << text_field_tag(:amount)
        end
        string << submit_tag('Roll Dice')
      end.html_safe
    end
  end

  def draw_card_form
    form_tag(game_card_draws_path(@game)) do
      "".tap do |string|
        string << label_tag(:card)
        string << select_tag(:card, options_for_select(["No card"] + @game_state.cards))
        string << submit_tag('Draw card')
      end.html_safe
    end
  end

  def end_turn_form
    form_tag(game_turn_ends_path(@game)) do
      "".tap do |string|
        string << submit_tag('End turn')
      end.html_safe
    end
  end

  def pay_bond_form
    form_tag(game_bond_payments_path(@game)) do
      "".tap do |string|
        string << submit_tag('Pay bond')
      end.html_safe
    end
  end

  def buy_property_form
    form_tag(game_property_purchases_path(@game)) do
      "".tap do |string|
        string << submit_tag('Buy property')
      end.html_safe
    end
  end

  def buy_houses_form
    form_tag(game_house_purchases_path(@game)) do
      "".tap do |string|
        string << label_tag(:property)
        string << select_tag(:property, options_for_select(current_game_player.possible_house_locations))
        string << submit_tag('Buy house')
      end.html_safe
    end
  end

  def buy_hotel_form
    form_tag(game_hotel_purchases_path(@game)) do
      "".tap do |string|
        string << label_tag(:property)
        string << select_tag(:property, options_for_select(current_game_player.possible_hotel_locations))
        string << submit_tag('Buy hotel')
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
                string << content_tag(:div, t(property.name))
                string << content_tag(:div, id: (to_id(property.name) + "_houses")) do
                  t("with #{pluralize(@game_state.player(user).houses[property.name], "house")}")
                end if @game_state.player(user).houses[property.name]
                string << content_tag(:div, id: (to_id(property.name) + "_hotel")) do
                  t("and a hotel")
                end if @game_state.player(user).hotels[property.name]
              end
            end.html_safe
          end
        end
      end.html_safe
    end
  end

  def to_id(string)
    string.downcase.gsub(" ", "_")
  end
end
