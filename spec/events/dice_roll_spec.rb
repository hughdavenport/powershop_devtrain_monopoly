require 'rails_helper'

RSpec.describe DiceRoll, type: :event do
  let(:game_state) do
    instance_double("GameState").tap do |game_state|

    end
  end

  subject(:event) { DiceRoll.new(amount: amount) }

  let(:amount) { nil }

  describe "checking validity" do
    before do
      expect(game_state).to receive(:started?) { started }
    end

    context "when the game is not started yet" do
      let(:started) { false }

      describe "#can_apply?" do
        subject { event.can_apply?(game_state) }

        it { is_expected.to be_falsey }
      end

      describe "#errors" do
        before do
          expect(game_state).to receive(:expecting_rolls) { 1 }
        end

        subject { event.errors(game_state) }

        it { is_expected.to be_present }
      end
    end

    context "when the game is started" do
      let(:started) { true }

      before do
        expect(game_state).to receive(:expecting_rolls) { expecting_rolls }
      end

      context "when I can't roll the dice" do
        let(:expecting_rolls) { 0 }

        describe "#can_apply?" do
          subject { event.can_apply?(game_state) }

          it { is_expected.to be_falsey }
        end

        describe "#errors" do
          subject { event.errors(game_state) }

          it { is_expected.to be_present }
        end
      end

      context "when I can roll the dice" do
        let(:expecting_rolls) { 1 }

        describe "#can_apply?" do
          subject { event.can_apply?(game_state) }

          it { is_expected.to be_truthy }
        end

        describe "#errors" do
          subject { event.errors(game_state) }

          it { is_expected.not_to be_present }
        end
      end
    end
  end

  context "when I supply an amount" do
    let(:amount) { 30 }

    describe "#amount" do
      it "should be the same" do
        expect(event.amount).to be amount
      end
    end
  end

  context "when I don't supply an amount" do
    describe "#amount" do
      subject { event.amount }

      it { is_expected.to be <= 6 }
      it { is_expected.to be >= 1 }
    end
  end

  describe "applying the event" do
  end
end
