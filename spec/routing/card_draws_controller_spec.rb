require "rails_helper"

RSpec.describe CardDrawsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => "/games/1/card_draws").to route_to("card_draws#create", :game_id => "1")
    end
  end
end
