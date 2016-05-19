require 'rails_helper'

def expect_effect_called(event_name, with = no_args)
  event = instance_double(event_name).tap do |event|
    expect(event).to receive(:apply).with(game_state)
  end
  class_double(event_name).as_stubbed_const.tap do |klass|
    expect(klass).to receive(:new).with(with).and_return(event)
  end
end

RSpec.describe DiceRolled, type: :event do
  let(:game_state) do
    instance_double("GameState").tap do |game_state|

    end
  end

  subject(:event) { DiceRolled.new(amount: amount) }

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

      describe "#errors" do
        before do
          expect(game_state).to receive(:expecting_rolls).and_return(1)
        end

        subject { event.errors(game_state) }

        it { is_expected.to be_present }
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
    before do
      expect(game_state).to receive(:current_player).and_return(0)
      expect(game_state).to receive(:players).and_return([player])
      expect(game_state).to receive(:expecting_rolls).at_least(:once).and_return(expected_rolls)
      expect(game_state).to receive(:expecting_rolls=).with(expected_rolls - 1)
    end

    let(:player) do
      double("Player").tap do |player|
        expect(player).to receive(:roll_dice).with(event.amount)
        expect(player).to receive(:jail?).and_return(jail)
      end
    end

    let(:dice_rolls) { double("DiceRolls") }

    let(:expected_rolls) { 1 }

    context "when I am in jail" do
      let(:jail) { true }

      it "should apply a rolled dice while in jail event" do
        expect_effect_called("DiceRolledWhileInJail")
        event.apply(game_state)
      end
    end

    context "when I am not in jail" do
      let(:jail) { false }

      before do
        expect(player).to receive(:dice_rolls).at_least(:once).and_return(dice_rolls)
        expect(dice_rolls).to receive(:size).at_least(:once).and_return(dice_rolls_size)
      end

      context "and I roll once" do
        let(:dice_rolls_size) { 1 }

        context "and I haven't landed on an owned utility" do
          it "should apply a dice rolled while not in jail effect" do
            expect_effect_called("DiceRolledWhileNotInJail")
            event.apply(game_state)
          end
        end

        context "and I have landed on an owned utility" do
          let(:expected_rolls) { 2 }
          let(:dice_roll) { 3 }

          before do
            expect(dice_rolls).to receive(:pop).and_return(dice_roll)
          end

          it "should apply a dice rolled for utility rent event" do
            expect_effect_called("DiceRolledForUtilityRent", dice_roll: dice_roll)
            event.apply(game_state)
          end
        end
      end

      context "and I roll twice" do
        let(:dice_rolls_size) { 2 }

        it "should apply a dice rolled while not in jail effect" do
          expect_effect_called("DiceRolledWhileNotInJail")
          event.apply(game_state)
        end
      end
    end
  end
end
