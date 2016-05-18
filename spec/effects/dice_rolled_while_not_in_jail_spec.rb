require 'rails_helper'

def expect_effect_called(event_name, with = no_args)
  event = instance_double(event_name).tap do |event|
    expect(event).to receive(:apply).with(game_state)
  end
  class_double(event_name).as_stubbed_const.tap do |klass|
    expect(klass).to receive(:new).with(with).and_return(event)
  end
end

RSpec.describe DiceRolledWhileNotInJail, type: :effect do
  let(:game_state) { instance_double("GameState") }

  subject(:event) { DiceRolledWhileNotInJail.new }

  describe "applying the effect" do
    before do
      expect(game_state).to receive(:current_player).and_return(0)
      expect(game_state).to receive(:players).and_return([player])
    end

    let(:player) do
      double("Player").tap do |player|
        expect(player).to receive(:[]).with(:dice_rolls).at_least(:once).and_return(dice_rolls)
      end
    end

    let(:dice_rolls) do
      double("DiceRolls").tap do |dice_rolls|
        expect(dice_rolls).to receive(:size).and_return(dice_rolls_size)
      end
    end

    context "and I roll once" do
      let(:dice_rolls_size) { 1 }

      it "should still have no effect" do
        event.apply(game_state)
      end
    end

    context "and I roll twice" do
      let(:dice_rolls_size) { 2 }

      context "and they are doubles" do
        before do
          expect(dice_rolls).to receive(:uniq).and_return([1])
          expect(player).to receive(:[]).with(:doubles_in_a_row).twice.and_return(doubles_in_a_row)
          expect(player).to receive(:[]=).with(:doubles_in_a_row, doubles_in_a_row + 1)
        end

        context "and I have rolled 3 doubles in a row" do
          let(:doubles_in_a_row) { 3 }

          it "should apply a go to jail event" do
            expect_effect_called("SentToJail")
            event.apply(game_state)
          end
        end

        context "and I haven't rolled 3 doubles in a row" do
          let(:doubles_in_a_row) { 1 }

          before do
            # Get an extra turn
            expect(game_state).to receive(:expecting_rolls).and_return(expected_rolls)
            expect(game_state).to receive(:expecting_rolls=).with(expected_rolls + 2)
          end

          let(:expected_rolls) { 0 }
          let(:original_location) { 20 }
          let(:new_location) { original_location }

          it "should apply a shift player event" do
            expect_effect_called("PlayerShifted")
            event.apply(game_state)
          end
        end
      end

      context "and they are not doubles" do
        before do
          expect(dice_rolls).to receive(:uniq).and_return([1, 2])
          expect(player).to receive(:[]).with(:doubles_in_a_row).and_return(0)
        end

        it "should apply a shift player event" do
          expect_effect_called("PlayerShifted")
          event.apply(game_state)
        end
      end
    end
  end
end
