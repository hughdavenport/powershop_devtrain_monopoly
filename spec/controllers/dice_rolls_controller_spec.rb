require 'rails_helper'

RSpec.describe DiceRollsController, type: :controller do
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
    # Mock out service that is going to be called
    before do
      roll_dice_service
      # Set up redirect to
      allow(game).to receive(:to_model).and_return(game)
      allow(game).to receive(:model_name).and_return(game)
      allow(game).to receive(:persisted?).and_return(true)
      allow(game).to receive(:singular_route_key).and_return("game")
    end

    let(:roll_dice_service) do
      class_double("RollDice").as_stubbed_const.tap do |roll_dice_service|
        expect(roll_dice_service).to receive(:new).with(game: game, amount: amount).and_return(service)
      end
    end

    let(:service) do
      double("RollDice").tap do |service|
        expect(service).to receive(:call).and_return(return_value)
      end
    end

    let(:amount) { nil }

    context "with valid game state" do
      let(:return_value) { true }

      before { post :create, {game_id: game_id, amount: amount, username: username}, valid_session }

      it "has a success notice" do
        expect(flash[:notice]).to eq "Dice rolled"
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

      before { post :create, {game_id: game_id, amount: amount, username: username}, valid_session }

      it "has errors" do
        expect(flash[:alert]).to eq errors: errors
      end

      it "redirects to the game" do
        expect(response).to redirect_to(game)
      end
    end

    context "passing in our own amount" do
      let(:amount) { "10" }
      let(:return_value) { true }

      before { post :create, {game_id: game_id, amount: amount, username: username}, valid_session }

      it "has a success notice" do
        expect(flash[:notice]).to eq "Dice rolled"
      end

      it "redirects to the game" do
        expect(response).to redirect_to(game)
      end
    end
  end
end
