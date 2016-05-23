require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe GamesController, type: :controller do
  # Inputs
  let(:piece) { "piece" }
  let(:game_id) { "1" }
  let(:username) { "testing" }
  let(:attributes) { { number_of_players: "2" } }

  # Mock out models that controller always uses
  before do
    game_model
    user_model
  end

  let(:game_model) { class_double("Game").as_stubbed_const }

  # Used by application controller
  let(:user_model) do
    class_double("User").as_stubbed_const.tap do |user_model|
      expect(user_model).to receive(:find_by_username).with(username).and_return(user)
    end
  end


  # These are returned by the stubbed models
  let(:user) { double("User") }


  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GamesController. Be sure to keep this updated too.
  let(:valid_session) { {} }


  describe "GET #index" do
    before do
      expect(game_model).to receive(:all).and_return(games)
    end

    let(:games) { "testing" }

    before { get :index, {username: username}, valid_session }

    it "assigns all games as @games" do
      expect(assigns(:games)).to eq games
    end
  end

  describe "GET #show" do
    before do
      expect(game_model).to receive(:find).with(game_id).and_return(game)
    end

    let(:game) do
      double("Game").tap do |game|
        expect(game).to receive(:state).and_return(game_state)
        expect(game).to receive(:number_of_players).and_return(2)
      end
    end

    let(:game_state) do
      double("GameState").tap do |game_state|
        expect(game_state).to receive(:players).and_return(players)
      end
    end

    before { get :show, {:id => game_id, username: username}, valid_session }

    context "when there are not enough players" do
      let(:players) { [] }

      it "redirects to the players list" do
        expect(response).to redirect_to(game_players_path(game))
      end
    end

    context "when there are the right number of players" do
      let(:players) { [ 1, 2 ] }

      it "assigns the requested game as @game" do
        expect(assigns(:game)).to eq(game)
      end
    end
  end

  describe "GET #new" do
    before do
      expect(game_model).to receive(:new).and_return(game)
    end

    let(:game) { double("Game") }

    before { get :new, {:username => username}, valid_session }

    it "assigns a new game as @game" do
      expect(assigns(:game)).to eq game
    end
  end

  describe "POST #create" do
    before do
      expect(game_model).to receive(:new).with(attributes).and_return(game)
    end

    let(:game) do
      double("Game").tap do |game|
        expect(game).to receive(:save).and_return(return_value)
        # Set up redirect to
        allow(game).to receive(:to_model).and_return(game)
        allow(game).to receive(:model_name).and_return(game)
        allow(game).to receive(:persisted?).and_return(true)
        allow(game).to receive(:singular_route_key).and_return("game")
      end
    end

    before { post :create, {:game => attributes, username: username}, valid_session }

    context "with valid params" do
      let(:return_value) { true }

      it "assigns a newly created game as @game" do
        expect(assigns(:service).game).to eq game
      end

      it "redirects to the created game" do
        expect(response).to redirect_to(game)
      end

      it "has a success notice" do
        expect(flash[:notice]).to eq "Game was successfully created."
      end
    end

    context "with invalid params" do
      let(:return_value) { false }

      it "assigns a newly created but unsaved game as @game" do
        expect(assigns(:service).game).to eq game
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      expect(game_model).to receive(:find).with(game_id).and_return(game)
    end

    let(:game) do
      double("Game").tap do |game|
        expect(game).to receive(:destroy)
      end
    end

    before { delete :destroy, {:id => game_id, username: username}, valid_session }

    it "destroys the requested game" do
    end

    it "redirects to the games list" do
      expect(response).to redirect_to(games_url)
    end
  end

end
