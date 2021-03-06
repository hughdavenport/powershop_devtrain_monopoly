require "rails_helper"

RSpec.describe HousePurchasesController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => "/games/1/house_purchases").to route_to("house_purchases#create", :game_id => "1")
    end
  end
end
