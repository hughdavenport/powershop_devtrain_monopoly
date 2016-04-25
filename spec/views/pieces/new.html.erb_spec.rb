require 'rails_helper'

RSpec.describe "pieces/new", type: :view do
  before(:each) do
    assign(:piece, Piece.new(
      :player => nil,
      :name => "MyString"
    ))
  end

  it "renders new piece form" do
    render

    assert_select "form[action=?][method=?]", pieces_path, "post" do

      assert_select "input#piece_player_id[name=?]", "piece[player_id]"

      assert_select "input#piece_name[name=?]", "piece[name]"
    end
  end
end
