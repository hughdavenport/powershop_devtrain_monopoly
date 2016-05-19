require "rails_helper"

RSpec.describe HotelPurchasesController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => "/games/1/hotel_purchases").to route_to("hotel_purchases#create", :game_id => "1")
    end
  end
end
