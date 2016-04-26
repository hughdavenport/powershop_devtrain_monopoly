require 'rails_helper'

RSpec.describe "players/show", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      number_of_players: 2
    ))
    @player = assign(:player, Player.create!(
      :game => @game
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
