require 'rails_helper'

RSpec.describe RollDice, type: :service do
  let(:game) do
    instance_double("Game").tap do |game|
      expect(game).to receive(:with_lock) { |&block| block.call }
      expect(game).to receive(:state).at_least(:once).and_return(:game_state)
    end
  end

  let(:game_state) do
    instance_double("GameState").tap do |game_state|
    end
  end

  before do
    dice_roll_event
  end

  let(:dice_roll_event) do
    class_double("DiceRoll").as_stubbed_const.tap do |dice_roll|
      expect(dice_roll).to receive(:new).with(amount: amount).and_return(event)
    end
  end

  let(:event) do
    double("DiceRoll").tap do |event|
      expect(event).to receive(:can_apply?).and_return(can_apply)
    end
  end

  subject(:service) { RollDice.new(game: game, amount: amount) }

  let(:amount) { nil }

  context "when the game state is valid" do
    let(:can_apply) { true }

    before do
      expect(game).to receive(:events).and_return([])
    end

    describe "#call" do
      it "succeeds" do
        expect(service.call).to be_truthy
      end
    end

    describe "#errors" do
      let(:errors) { [] }

      before do
        expect(event).to receive(:errors).and_return(errors)
      end

      it "should not return errors" do
        service.call
        expect(service.errors).not_to be_present
      end
    end

    describe "#game" do
      it "returns the given value" do
        service.call
        expect(service.game).to be game
      end
    end
  end

  context "when the game state is invalid" do
    let(:can_apply) { false }

    describe "#call" do
      it "fails" do
        expect(service.call).to be_falsey
      end
    end

    describe "#errors" do
      let(:errors) { [1] }

      before do
        expect(event).to receive(:errors).and_return(errors)
      end

      it "should return errors" do
        service.call
        expect(service.errors).to be errors
      end
    end

    describe "#game" do
      it "returns the given value" do
        service.call
        expect(service.game).to be game
      end
    end
  end

  context "when a custom amount is supplied" do
    let(:amount) { 100 }
    let(:can_apply) { true }

    before do
      expect(game).to receive(:events).and_return([])
    end

    describe "#call" do
      it "succeeds" do
        expect(service.call).to be_truthy
      end
    end
  end
end
