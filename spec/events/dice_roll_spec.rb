require 'rails_helper'

RSpec.describe DiceRoll, type: :event do
  pending "Test expecting dice roll passes"
  pending "Test opposite"
  pending "Test not started"
  pending "Test current turn and not"

  let(:game_state) do
    instance_double("GameState").tap do |game_state|

    end
  end

  subject(:event) { DiceRoll.new(amount: amount) }

  let(:amount) { nil }

  describe "checking validity" do
    before do
      expect(game_state).to receive(:started?).and_return(started)
    end

    context "when the game is not started yet" do
      let(:started) { false }

      describe "#can_apply?" do
        subject { event.can_apply?(game_state) }

        it { is_expected.to be_falsey }
      end
    end

    context "when the game is started" do
      let(:started) { true }

      before do
        expect(game_state).to receive(:expecting_rolls).and_return(expecting_rolls)
      end

      context "when I can't roll the dice" do
        let(:expecting_rolls) { 0 }

        describe "#can_apply?" do
          subject { event.can_apply?(game_state) }

          it { is_expected.to be_falsey }
        end
      end

      context "when I can roll the dice" do
        let(:expecting_rolls) { 1 }

        describe "#can_apply?" do
          subject { event.can_apply?(game_state) }

          it { is_expected.to be_truthy }
        end
      end
    end
  end

  describe "applying the event" do
  end
end
