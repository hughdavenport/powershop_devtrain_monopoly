require 'rails_helper'

RSpec.describe "Players", type: :request do
  let(:game_attributes) { skip("TODO") }
  let(:game) { Game.create!(game_attributes) }

  describe "GET /games/1/players" do
    it "works! (now write some real specs)" do
      get game_players_path(game)
      expect(response).to have_http_status(200)
    end
  end
end
