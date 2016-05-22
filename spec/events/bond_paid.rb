require 'rails_helper'

def expect_effect_called(event_name, with = no_args)
  event = instance_double(event_name).tap do |event|
    expect(event).to receive(:apply).with(game_state)
  end
  class_double(event_name).as_stubbed_const.tap do |klass|
    expect(klass).to receive(:new).with(with).and_return(event)
  end
end

RSpec.describe BondPaid, type: :event do
  let(:game_state) do
    instance_double("GameState").tap do |game_state|

    end
  end

  subject(:event) { BondPaid.new }

  let(:amount) { nil }

  describe "checking validity" do
    before do
      expect(game_state).to receive(:expecting_rolls).and_return(expecting_rolls)
    end

    context "when have already rolled the dice" do
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

    context "when we have not rolled the dice" do
      let(:expecting_rolls) { 2 }

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
    it "should call bond posted effect" do
      expect_effect_called("BondPosted")
      event.apply(game_state)
    end
  end
end
