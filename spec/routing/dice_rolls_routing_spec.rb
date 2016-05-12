require "rails_helper"

RSpec.describe DiceRollsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => "/games/1/dice_rolls").to route_to("dice_rolls#create", :game_id => "1")
    end
  end
end
