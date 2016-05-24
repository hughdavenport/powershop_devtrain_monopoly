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

  subject(:event) { CardDrawn.new(card: card) }

  let(:card) { "testing" }

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
      expect(game_state).to receive(:expecting_card_draw=).with(false)
    end

    context "when we are just using the 'No card' testing value" do
      let(:card) { 'No card' }

      it "should apply with no extra effects" do
        event.apply(game_state)
      end
    end

    context "when we are not applying with testing card of 'No card'" do
      before do
        expect(game_state).to receive(:cards).and_return(cards)
      end

      let(:cards) do
        double("Cards").tap do |cards|
          expect(cards).to receive(:find).with(no_args).and_return(card_obj)
        end
      end

      let(:card_obj) do
        double("Card").tap do |card_obj|
          expect(card_obj).to receive(:respond_to?).with(:effect).and_return(respond_to)
        end
      end

      context "when the card has no effect" do
        let(:respond_to) { false }

        it "should apply with no extra effect" do
          event.apply(game_state)
        end
      end

      context "when the card has an extra effect" do
        let(:respond_to) { true }

        before do
          expect(card_obj).to receive(:effect).and_return(effect)
        end

        let(:effect) do
          double("Effect").tap do |effect|
            expect(effect).to receive(:apply).with(game_state)
          end
        end

        it "should apply with the extra effect" do
          event.apply(game_state)
        end
      end
    end
  end
end
