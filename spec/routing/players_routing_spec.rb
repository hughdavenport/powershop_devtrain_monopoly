require "rails_helper"

RSpec.describe PlayersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/games/1/players").to route_to("players#index", :game_id => "1")
    end

    it "routes to #new" do
      expect(:get => "/games/1/players/new").to route_to("players#new", :game_id => "1")
    end

    it "routes to #create" do
      expect(:post => "/games/1/players").to route_to("players#create", :game_id => "1")
    end
  end
end
