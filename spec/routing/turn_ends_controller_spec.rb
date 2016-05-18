require "rails_helper"

RSpec.describe TurnEndsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => "/games/1/turn_ends").to route_to("turn_ends#create", :game_id => "1")
    end
  end
end
