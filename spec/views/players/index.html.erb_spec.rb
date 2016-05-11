require 'rails_helper'

RSpec.describe "players/index", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      number_of_players: 2
    ))
    user = User.create!(username: "testing1")
    AddPlayerToGame.new(game: @game, piece: :wheelbarrow, user: user).call
    user = User.create!(username: "testing2")
    AddPlayerToGame.new(game: @game, piece: :battleship, user: user).call
    @game_state = assign(:game_state, GameState.create(@game))
  end

  it "renders a list of players" do
    render
    assert_select "tr>td", :count => 4
  end
end
