require 'rails_helper'

RSpec.describe "players/edit", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      number_of_players: 2
    ))
    @player = assign(:player, Player.create!(
      game: @game
    ))
  end

  it "renders the edit player form" do
    render

    assert_select "form[action=?][method=?]", game_player_path(@game, @player), "post" do

      assert_select "input#player_user_id[name=?]", "player[user_id]"
    end
  end
end
