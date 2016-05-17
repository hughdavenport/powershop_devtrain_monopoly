require 'rails_helper'

RSpec.describe TurnEnded, type: :event do
  let(:game_state) do
    instance_double("GameState").tap do |game_state|

    end
  end

  subject(:event) { TurnEnded.new }

  let(:amount) { nil }

  describe "checking validity" do
    before do
      expect(game_state).to receive(:expecting_rolls).and_return(expecting_rolls)
    end

    context "when we are required to roll the dice" do
      let(:expecting_rolls) { 2 }

      describe "#can_apply?" do
        subject { event.can_apply?(game_state) }

        it { is_expected.to be_falsey }
      end

      describe "#errors" do
        subject { event.errors(game_state) }

        it { is_expected.to be_present }
      end
    end

    context "when we are not required to roll the dice" do
      let(:expecting_rolls) { 0 }

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

  describe "applying the event" do
    before do
      expect(game_state).to receive(:current_player).and_return(0)
      expect(game_state).to receive(:players).and_return([player])
    end

    let(:player) { double("Player") }

    it "should end my turn" do
      expect(game_state).to receive(:end_turn!).with(player)
      event.apply(game_state)
    end
  end
end
