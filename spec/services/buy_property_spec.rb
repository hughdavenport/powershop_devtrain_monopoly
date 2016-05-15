require 'rails_helper'

RSpec.describe BuyProperty, type: :service do
  let(:game_params) { { number_of_players: 2 } }
  let(:game) { Game.create!(game_params) }
  before { AddPlayerToGame.new(game: game, user: firstuser, piece: firstpiece).call[-1].apply(game.state) }
  before { AddPlayerToGame.new(game: game, user: seconduser, piece: secondpiece).call[-1].apply(game.state) }
  let(:firstuser) { User.create!(username: "firstuser") }
  let(:firstpiece) { "dog" }
  let(:seconduser) { User.create!(username: "seconduser") }
  let(:secondpiece) { "hat" }

  subject(:service) { BuyProperty.new(game: game) }

  context "when it is my turn" do
    # TODO how do we set up my turn?, override what game does
    # TODO also check whether this can be brought at all
    # TODO this spec and roll dice needs mocking out a lot!

    describe "buying the property" do
      it "succeeds" do
        expect(service.call).to be_truthy
      end

      it "adds a purchase event" do
        expect { service.call }.to change(PurchaseProperty, :count).by(1)
      end

      it "adds the purchase event to the correct game" do
        service.call
        expect(PurchaseProperty.last.game).to eql game
      end

      it "has no errors" do
        service.call
        expect(service.errors).not_to be_present
      end
    end
  end

  context "when it is not my turn" do
    # TODO how to set up?, this should fail
  end
end
