require "rails_helper"

RSpec.describe PropertyPurchasesController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => "/games/1/property_purchases").to route_to("property_purchases#create", :game_id => "1")
    end
  end
end
