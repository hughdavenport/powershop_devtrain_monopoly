require 'rails_helper'

RSpec.describe RollDice, type: :service do
  let(:game_params) { { number_of_players: 2 } }
  let(:game) { Game.create!(game_params) }

  subject(:service) { RollDice.new(game: game) }

  context "when it is my turn" do
    # TODO how do we set up my turn?, override what game does

    describe "rolling the dice" do
      it "succeeds" do
        expect(service.call).to be_truthy
      end

      it "adds a dice roll" do
        expect { service.call }.to change(DiceRoll, :count).by(1)
      end

      it "adds the dice roll to the correct game" do
        service.call
        expect(DiceRoll.last.game).to eql game
      end

      it "has a valid dice roll" do
        service.call
        expect(DiceRoll.last.amount).to be_present
        expect(DiceRoll.last.amount).to be < 7
        expect(DiceRoll.last.amount).to be > 0
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
