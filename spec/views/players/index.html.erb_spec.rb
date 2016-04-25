require 'rails_helper'

RSpec.describe "players/index", type: :view do
  before(:each) do
    assign(:players, [
      Player.create!(
        :game => nil
      ),
      Player.create!(
        :game => nil
      )
    ])
  end

  it "renders a list of players" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
