require 'rails_helper'

def expect_event_called(event_name)
  class_double(event_name).as_stubbed_const.tap do |event|
    expect(event).to receive(:new) { event }
    expect(event).to receive(:apply).with(game_state)
  end
end

RSpec.describe DiceRoll, type: :event do
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
      expect(game_state).to receive(:current_player) { 0 }
      expect(game_state).to receive(:players) { [player] }
    end

    let(:player) do
      double("Player").tap do |player|
        expect(player).to receive(:[]).with(:dice_rolls).at_least(:once) { dice_rolls }
        expect(player).to receive(:[]).with(:in_jail) { in_jail }
      end
    end

    let(:dice_rolls) do
      double("DiceRolls").tap do |dice_rolls|
        expect(dice_rolls).to receive(:<<).with(event.amount)
        expect(dice_rolls).to receive(:size) { dice_rolls_size }
      end
    end

    context "when I am in jail" do
      let(:in_jail) { true }

      context "and I roll once" do
        let(:dice_rolls_size) { 1 }

        it "should still require one more roll" do
          expect(game_state).to receive(:expecting_rolls) { 2 }
          expect(game_state).to receive(:expecting_rolls=) { 1 }
          event.apply(game_state)
        end
      end

      context "and I roll twice" do
        let(:dice_rolls_size) { 2 }

        context "and they are doubles" do
          before do
            expect(dice_rolls).to receive(:uniq) { [1] }
          end

          it "should apply a break out of jail event" do
            expect_event_called("BreakOutOfJail")
            event.apply(game_state)
          end
        end

        context "and they are not doubles" do
          before do
            expect(dice_rolls).to receive(:uniq).and_return([1,2])
            expect(player).to receive(:[]).with(:pairs_rolled_while_in_jail).twice { pairs_rolled_while_in_jail }
            expect(player).to receive(:[]=).with(:pairs_rolled_while_in_jail, pairs_rolled_while_in_jail + 1)
          end

          context "and we have been in jail for 3 turns" do
            let(:pairs_rolled_while_in_jail) { 3 }

            it "should apply a pay bond event" do
              expect_event_called("PayBond")
              event.apply(game_state)
            end
          end

          context "and we have not been in jail for 3 turns" do
            let(:pairs_rolled_while_in_jail) { 1 }

            it "should set the state to not require any more rolls" do
              expect(game_state).to receive(:expecting_rolls) { 1 }
              expect(game_state).to receive(:expecting_rolls=) { 0 }
              event.apply(game_state)
            end
          end
        end
      end
    end

    context "when I am not in jail" do
      let(:in_jail) { false }

      context "and I roll once" do
        let(:dice_rolls_size) { 1 }

        it "should still require one more roll" do
          expect(game_state).to receive(:expecting_rolls) { 2 }
          expect(game_state).to receive(:expecting_rolls=) { 1 }
          event.apply(game_state)
        end
      end

      context "and I roll twice" do
        let(:dice_rolls_size) { 2 }

        context "and they are doubles" do
          before do
            expect(dice_rolls).to receive(:uniq) { [1] }
            expect(player).to receive(:[]).with(:doubles_in_a_row).twice { doubles_in_a_row }
            expect(player).to receive(:[]=).with(:doubles_in_a_row, doubles_in_a_row + 1)
          end

          context "and I have rolled 3 doubles in a row" do
            let(:doubles_in_a_row) { 3 }

            it "should apply a go to jail event" do
              expect_event_called("GoToJail")
              event.apply(game_state)
            end
          end

          context "and I haven't rolled 3 doubles in a row" do
            let(:doubles_in_a_row) { 1 }

            before do
              # Get an extra turn, then decrement
              expect(game_state).to receive(:expecting_rolls) { 1 }
              expect(game_state).to receive(:expecting_rolls=) { 3 }
              expect(game_state).to receive(:expecting_rolls) { 3 }
              expect(game_state).to receive(:expecting_rolls=) { 2 }
            end

            let(:original_location) { 20 }
            let(:new_location) { original_location }

            it "should apply a shift player event" do
              expect_event_called("ShiftPlayer")
              event.apply(game_state)
            end
          end
        end

        context "and they are not doubles" do
          before do
            expect(dice_rolls).to receive(:uniq) { [1, 2] }
            expect(player).to receive(:[]).with(:doubles_in_a_row) { 0 }
            expect(game_state).to receive(:expecting_rolls) { 1 }
            expect(game_state).to receive(:expecting_rolls=) { 0 }
          end

          it "should apply a shift player event" do
            expect_event_called("ShiftPlayer")
            event.apply(game_state)
          end
        end
      end
    end
  end
end
