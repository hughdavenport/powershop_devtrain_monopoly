require 'rails_helper'

RSpec.describe "games/index", type: :view do
  before(:each) do
    assign(:games, [
      Game.create!(number_of_players: 2),
      Game.create!(number_of_players: 2)
    ])
  end

  it "renders a list of games" do
    render
  end
end
