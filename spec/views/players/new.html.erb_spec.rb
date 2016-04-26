require 'rails_helper'

RSpec.describe "players/new", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      number_of_players: 2
    ))
    assign(:player, Player.new(
      :game => @game
    ))
  end

  it "renders new player form" do
    render

    assert_select "form[action=?][method=?]", game_players_path(@game), "post" do

      assert_select "select#player_piece[name=?]", "player[piece]"
    end
  end
end
