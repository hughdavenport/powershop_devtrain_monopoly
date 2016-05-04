require 'rails_helper'

RSpec.describe "Games", type: :request do
  let(:username) { "testing" }
  before(:each) { User.create!(username: username) }

  describe "GET /games" do
    it "works! (now write some real specs)" do
      get games_path, username: username
      expect(response).to have_http_status(200)
    end
  end
end
