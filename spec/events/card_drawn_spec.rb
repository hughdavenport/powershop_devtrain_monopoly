require 'rails_helper'

def expect_effect_called(event_name, with = no_args)
  event = instance_double(event_name).tap do |event|
    expect(event).to receive(:apply).with(game_state)
  end
  class_double(event_name).as_stubbed_const.tap do |klass|
    expect(klass).to receive(:new).with(with).and_return(event)
  end
end

RSpec.describe CardDrawn, type: :event do
  let(:game_state) do
    instance_double("GameState").tap do |game_state|

    end
  end

  subject(:event) { CardDrawn.new }

  let(:amount) { nil }

  describe "checking validity" do
    before do
      expect(game_state).to receive(:expecting_card_draw).and_return(expecting_card_draw)
    end

    context "when we aren't expected to draw a card" do
      let(:expecting_card_draw) { false }

      describe "#can_apply?" do
        subject { event.can_apply?(game_state) }

        it { is_expected.to be_falsey }
      end

      describe "#errors" do
        subject { event.errors(game_state) }

        it { is_expected.to be_present }
      end
    end

    context "when we are expected to draw a card" do
      let(:expecting_card_draw) { true }

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
      expect(game_state).to receive(:expecting_card_draw=).with(false)
    end

    let(:player) { double("Player") }

    it "should apply" do
      event.apply(game_state)
    end
  end
end
