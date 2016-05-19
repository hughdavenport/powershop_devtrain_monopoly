require 'rails_helper'

def expect_effect_called(event_name, with = no_args)
  event = instance_double(event_name).tap do |event|
    expect(event).to receive(:apply).with(game_state)
  end
  class_double(event_name).as_stubbed_const.tap do |klass|
    expect(klass).to receive(:new).with(with).and_return(event)
  end
end

RSpec.describe DiceRolledWhileInJail, type: :effect do
  let(:game_state) { instance_double("GameState") }

  subject(:event) { DiceRolledWhileInJail.new }

  describe "applying the effect" do
    before do
      expect(game_state).to receive(:current_player).and_return(0)
      expect(game_state).to receive(:players).and_return([player])
    end

    let(:player) do
      double("Player").tap do |player|
        expect(player).to receive(:dice_rolls).at_least(:once).and_return(dice_rolls)
      end
    end

    let(:dice_rolls) do
      double("DiceRolls").tap do |dice_rolls|
        expect(dice_rolls).to receive(:size).and_return(dice_rolls_size)
      end
    end

    context "and I roll once" do
      let(:dice_rolls_size) { 1 }

      it "should have no effect" do
        event.apply(game_state)
      end
    end

    context "and I roll twice" do
      let(:dice_rolls_size) { 2 }

      context "and they are doubles" do
        before do
          expect(dice_rolls).to receive(:uniq).and_return([1])
        end

        it "should apply a break out of jail event" do
          expect_effect_called("BrokeOutOfJail")
          event.apply(game_state)
        end
      end

      context "and they are not doubles" do
        before do
          expect(dice_rolls).to receive(:uniq).and_return([1,2])
          expect(player).to receive(:pairs_rolled_while_in_jail).twice.and_return(pairs_rolled_while_in_jail)
          expect(player).to receive(:pairs_rolled_while_in_jail=).with(pairs_rolled_while_in_jail + 1)
        end

        context "and we have been in jail for 3 turns" do
          let(:pairs_rolled_while_in_jail) { 3 }

          it "should apply a pay bond event" do
            expect_effect_called("BondPosted")
            event.apply(game_state)
          end
        end

        context "and we have not been in jail for 3 turns" do
          let(:pairs_rolled_while_in_jail) { 1 }

          it "should apply with normal constraints" do
            event.apply(game_state)
          end
        end
      end
    end
  end
end
