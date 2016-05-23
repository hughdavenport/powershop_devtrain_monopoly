require 'rails_helper'

RSpec.describe ChanceCardsShuffled, type: :event do
  let(:game_state) do
    instance_double("GameState").tap do |game_state|

    end
  end

  subject(:event) { ChanceCardsShuffled.new }

  describe "checking validity" do
  end

  describe "applying the event" do
    before do
      expect(game_state).to receive(:chance_cards=)
    end

    it "it should set the chance cards order" do
      event.apply(game_state)
    end
  end
end
