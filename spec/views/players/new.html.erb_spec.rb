require 'rails_helper'

RSpec.describe "players/new", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      number_of_players: 2
    ))
    @game_state = assign(:game_state, @game.state)
  end

  it "renders new player form" do
    render

    assert_select "form[action=?][method=?]", game_players_path(@game), "post" do

      assert_select "select#piece[name=?]", "piece"
    end
  end
end
