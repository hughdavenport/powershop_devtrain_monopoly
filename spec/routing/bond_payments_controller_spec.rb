require "rails_helper"

RSpec.describe BondPaymentsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(:post => "/games/1/bond_payments").to route_to("bond_payments#create", :game_id => "1")
    end
  end
end
