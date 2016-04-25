require 'rails_helper'

RSpec.describe "pieces/index", type: :view do
  before(:each) do
    assign(:pieces, [
      Piece.create!(
        :player => nil,
        :name => "Name"
      ),
      Piece.create!(
        :player => nil,
        :name => "Name"
      )
    ])
  end

  it "renders a list of pieces" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
