require 'rails_helper'

RSpec.describe "games/show", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(number_of_players: 2))
    user = assign(:current_user, User.create!(username: "testing"))
    AddPlayerToGame.new(game: @game, user: user, piece: :wheelbarrow).call
    @game_state = assign(:game_state, @game.state)
  end

  it "renders attributes in <p>" do
    render
  end
end
