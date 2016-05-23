require 'rails_helper'

RSpec.describe CommunityChestCardsShuffled, type: :event do
  let(:game_state) do
    instance_double("GameState").tap do |game_state|

    end
  end

  subject(:event) { CommunityChestCardsShuffled.new }

  describe "checking validity" do
  end

  describe "applying the event" do
    before do
      expect(game_state).to receive(:community_chest_cards=)
    end

    it "it should set the community_chest cards order" do
      event.apply(game_state)
    end
  end
end
