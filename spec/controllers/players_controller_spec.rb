require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  # Inputs
  let(:piece) { "piece" }
  let(:game_id) { "1" }
  let(:username) { "testing" }

  # Mock out models that controller always uses
  before do
    game_model
    user_model
  end

  let(:game_model) do
    class_double("Game").as_stubbed_const.tap do |game_model|
      expect(game_model).to receive(:find).with(game_id).and_return(game)
    end
  end

  # Used by application controller
  let(:user_model) do
    class_double("User").as_stubbed_const.tap do |user_model|
      expect(user_model).to receive(:find_by_username).with(username).and_return(user)
    end
  end


  # These are returned by the stubbed models
  let(:game) { double("Game") }
  let(:user) { double("User") }


  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PlayersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    before do
      expect(game).to receive(:state).and_return(game_state)
    end

    let(:game_state) do
      double("GameState").tap do |game_state|
        expect(game_state).to receive(:players).and_return(players)
      end
    end

    let(:players) { "testing" }

    before { get :index, {game_id: game_id, username: username}, valid_session }

    it "assigns all players as @players" do
      expect(assigns(:players)).to eq players
    end
  end

  describe "GET #new" do
    before do
      expect(game).to receive(:state).and_return(game_state)
      expect(user).to receive(:id).and_return(user_id)
    end

    let(:game_state) do
      double("GameState").tap do |game_state|
        expect(game_state).to receive(:players).and_return(players)
      end
    end

    let(:user_id) { 1 }

    before { get :new, {game_id: game_id, username: username}, valid_session }

    context "already playing" do
      let(:players) { [ user_id ] }

      it "redirects to the players list" do
        expect(response).to redirect_to game_players_path
      end

      it "has a notice" do
        expect(flash[:notice]).to eq "You are already playing"
      end
    end

    context "not already playing in current game" do
      let(:players) { [] }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders the new template" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST #create" do
    # Mock out service that is going to be called
    before do
      add_player_to_game_service
      # Set up redirect to
      allow(game).to receive(:to_model).and_return(game)
      allow(game).to receive(:model_name).and_return(game)
      allow(game).to receive(:persisted?).and_return(true)
      allow(game).to receive(:singular_route_key).and_return("game")
    end

    let(:add_player_to_game_service) do
      class_double("AddPlayerToGame").as_stubbed_const.tap do |add_player_to_game_service|
        expect(add_player_to_game_service).to receive(:new).with(game: game, user: user, piece: piece).and_return(service)
      end
    end

    let(:service) do
      double("AddPlayerToGame").tap do |service|
        expect(service).to receive(:call).and_return(return_value)
      end
    end


    context "with valid params" do
      let(:return_value) { true }

      before { post :create, {game_id: game_id, :piece => piece, username: username}, valid_session }

      it "has a success notice" do
        expect(flash[:notice]).to eq "Player was successfully created."
      end

      it "redirects to the game" do
        expect(response).to redirect_to(game)
      end
    end

    context "with invalid params" do
      let(:return_value) { false }

      before do
        expect(service).to receive(:errors).and_return(errors)
      end

      let(:errors) do
        double("errors").tap do |errors|
          expect(errors).to receive(:full_messages).and_return(errors)
        end
      end

      before { post :create, {game_id: game_id, :piece => piece, username: username}, valid_session }

      it "has errors" do
        expect(flash[:alert]).to eq errors: errors
      end

      it "redirects to the game" do
        expect(response).to redirect_to(game)
      end
    end
  end
end
