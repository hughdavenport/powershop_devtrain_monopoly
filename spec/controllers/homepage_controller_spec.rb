require 'rails_helper'

RSpec.describe HomepageController, type: :controller do
  describe "GET #index" do
    before { get :index }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the home page template" do
      expect(response).to render_template(:index)
    end
  end
end
