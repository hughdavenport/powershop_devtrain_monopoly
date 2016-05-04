require 'rails_helper'

RSpec.describe "Players", type: :request do
  let(:game_attributes) { { number_of_players: 2 } }
  let(:game) { Game.create!(game_attributes) }

  let(:username) { "testing" }
  before(:each) { User.create!(username: username) }

  describe "GET /games/1/players" do
    it "works! (now write some real specs)" do
      get game_players_path(game), username: username
      expect(response).to have_http_status(200)
    end
  end
end
