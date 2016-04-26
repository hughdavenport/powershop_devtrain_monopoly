require "rails_helper"

RSpec.describe PlayersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/games/1/players").to route_to("players#index", :game_id => "1")
    end

    it "routes to #new" do
      expect(:get => "/games/1/players/new").to route_to("players#new", :game_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/games/1/players/1").to route_to("players#show", :game_id => "1", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/games/1/players/1/edit").to route_to("players#edit", :game_id => "1", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/games/1/players").to route_to("players#create", :game_id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/games/1/players/1").to route_to("players#update", :game_id => "1", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/games/1/players/1").to route_to("players#update", :game_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/games/1/players/1").to route_to("players#destroy", :game_id => "1", :id => "1")
    end

  end
end
