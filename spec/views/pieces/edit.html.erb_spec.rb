require 'rails_helper'

RSpec.describe "pieces/edit", type: :view do
  before(:each) do
    @piece = assign(:piece, Piece.create!(
      :player => nil,
      :name => "MyString"
    ))
  end

  it "renders the edit piece form" do
    render

    assert_select "form[action=?][method=?]", piece_path(@piece), "post" do

      assert_select "input#piece_player_id[name=?]", "piece[player_id]"

      assert_select "input#piece_name[name=?]", "piece[name]"
    end
  end
end
