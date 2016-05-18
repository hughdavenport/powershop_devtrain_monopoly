require 'rails_helper'

def expect_effect_called(event_name, with = no_args)
  event = instance_double(event_name).tap do |event|
    expect(event).to receive(:apply).with(game_state)
  end
  class_double(event_name).as_stubbed_const.tap do |klass|
    expect(klass).to receive(:new).with(with).and_return(event)
  end
end

RSpec.describe DiceRolledForUtilityRent, type: :effect do
  let(:game_state) { instance_double("GameState") }

  subject(:event) { DiceRolledForUtilityRent.new(dice_roll: dice_roll) }

  let(:dice_roll) { 30 }

  describe "applying the effect" do
    it "should apply the utilities rent paid effect" do
      expect_effect_called("UtilitiesRentPaid", dice_roll: dice_roll)
      event.apply(game_state)
    end
  end
end
