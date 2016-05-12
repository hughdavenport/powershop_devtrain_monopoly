require "rails_helper"

RSpec.describe HomepageController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/homepage").to route_to("homepage#index")
    end

    it "routes / to #index" do
      expect(:get => "/").to route_to("homepage#index")
    end
  end
end
