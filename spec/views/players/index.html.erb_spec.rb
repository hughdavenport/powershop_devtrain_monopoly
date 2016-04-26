require 'rails_helper'

RSpec.describe "players/index", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      number_of_players: 2
    ))
    assign(:players, [
      Player.create!(
        :game => @game
      ),
      Player.create!(
        :game => @game
      )
    ])
  end

  it "renders a list of players" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
