require 'rails_helper'

RSpec.describe EndTurnsController, type: :controller do
  # Inputs
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
  # TODO allow controller to recieve filter method, instead of doing user model
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

  describe "POST #create" do
    before do
      # Set up redirect to
      allow(game).to receive(:to_model).and_return(game)
      allow(game).to receive(:model_name).and_return(game)
      allow(game).to receive(:persisted?).and_return(true)
      allow(game).to receive(:singular_route_key).and_return("game")
      # Mock out state, used for checking whether it is our turn
      allow(game).to receive(:state).and_return(game_state)
      expect(user).to receive(:id)
    end

    let(:game_state) do
      double("GameState").tap do |game_state|
        expect(game_state).to receive(:players).and_return(players)
        expect(game_state).to receive(:current_player).and_return(0)
      end
    end

    let(:players) { [ "testing" ] }

    context "when it is not out turn" do
      before do
        expect(game_state).to receive(:player)
      end

      before { post :create, {game_id: game_id, username: username}, valid_session }

      it "should redirect" do
        expect(response).to redirect_to(game)
      end

      it "should have a flash message" do
        expect(flash[:danger]).to eq "Not your turn"
      end
    end

    context "when it is our turn" do
      before do
        # Make sure game_state matches our thoughts that we are logged in
        expect(game_state).to receive(:player).and_return(players[0])
        expect(game_state).to receive(:expecting_rolls).and_return(expecting_rolls)
      end

      context "and we have to roll the dice" do
        let(:expecting_rolls) { 1 }

        before { post :create, {game_id: game_id, username: username}, valid_session }

        it "should redirect" do
          expect(response).to redirect_to(game)
        end

        it "should have a flash message" do
          expect(flash[:danger]).to eq "Expecting dice roll"
        end
      end

      context "when we don't have to roll the dice" do
        let(:expecting_rolls) { 0 }

        before do
          # Mock out service that is going to be called
          end_turn_service
        end

        let(:end_turn_service) do
          class_double("EndTurn").as_stubbed_const.tap do |end_turn_service|
            expect(end_turn_service).to receive(:new).with(game: game).and_return(service)
          end
        end

        let(:service) do
          double("EndTurn").tap do |service|
            expect(service).to receive(:call).and_return(return_value)
          end
        end

        context "with valid game state" do
          let(:return_value) { true }

          before { post :create, {game_id: game_id, username: username}, valid_session }

          it "has a success notice" do
            expect(flash[:notice]).to eq "Turn ended"
          end

          it "redirects to the game" do
            expect(response).to redirect_to(game)
          end
        end

        context "with invalid game state" do
          let(:return_value) { false }

          before do
            expect(service).to receive(:errors).and_return(errors)
          end
          let(:errors) do
            double("errors").tap do |errors|
              expect(errors).to receive(:full_messages).and_return(errors)
            end
          end

          before { post :create, {game_id: game_id, username: username}, valid_session }

          it "has errors" do
            expect(flash[:alert]).to eq errors: errors
          end

          it "redirects to the game" do
            expect(response).to redirect_to(game)
          end
        end
      end
    end
  end
end
