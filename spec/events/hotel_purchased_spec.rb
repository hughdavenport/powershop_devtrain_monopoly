require 'rails_helper'

RSpec.describe HotelPurchased, type: :event do
  let(:game_state) do
    instance_double("GameState").tap do |game_state|

    end
  end

  subject(:event) { HotelPurchased.new(property: property) }

  let(:property) { "property" }

  describe "checking validity" do
    before do
      expect(game_state).to receive(:current_player).and_return(0)
      expect(game_state).to receive(:players).and_return([player])
      expect(game_state).to receive(:expecting_rolls).and_return(expecting_rolls)
    end

    let(:player) { instance_double("Player") }
    let(:price) { 50 }

    context "we have already rolled" do
      let(:expecting_rolls) { 0 }

      describe "#can_apply?" do
        subject { event.can_apply?(game_state) }

        it { is_expected.to be_falsey }
      end

      describe "#errors" do
        before do
          expect(player).to receive(:can_afford?).with(price).and_return(true)
          expect(player).to receive(:can_buy_hotel?).and_return(true)
          expect(hotel).to receive(:building_price).and_return(price)
          class_double("ColouredProperty").as_stubbed_const.tap do |coloured_property|
            expect(coloured_property).to receive(:find_by_name).with(property).and_return(hotel)
          end
        end

        let(:hotel) { instance_double("Hotel") }

        subject { event.errors(game_state) }

        it { is_expected.to be_present }
      end
    end

    context "we have not rolled this turn" do
      let(:expecting_rolls) { 2 }

      before do
        expect(player).to receive(:can_buy_hotel?).and_return(can_buy_hotel)
      end

      let(:hotel) do
        instance_double("Hotel").tap do |hotel|
          expect(hotel).to receive(:building_price).and_return(price)
        end
      end

      context "we are not allowed to buy a hotel" do
        let(:can_buy_hotel) { false }

        describe "#can_apply?" do
          subject { event.can_apply?(game_state) }

          it { is_expected.to be_falsey }
        end

        describe "#errors" do
          before do
            expect(player).to receive(:can_afford?).with(price).and_return(true)
            class_double("ColouredProperty").as_stubbed_const.tap do |coloured_property|
              expect(coloured_property).to receive(:find_by_name).with(property).and_return(hotel)
            end
          end

          subject { event.errors(game_state) }

          it { is_expected.to be_present }
        end
      end

      context "we are allowed to buy a hotel" do
        let(:can_buy_hotel) { true }

        before do
          expect(player).to receive(:can_afford?).with(price).and_return(can_afford)
          class_double("ColouredProperty").as_stubbed_const.tap do |coloured_property|
            expect(coloured_property).to receive(:find_by_name).with(property).and_return(hotel)
          end
        end

        context "but we can't afford to buy the hotel" do
          let(:can_afford) { false }

          describe "#can_apply?" do
            subject { event.can_apply?(game_state) }

            it { is_expected.to be_falsey }
          end

          describe "#errors" do
            subject { event.errors(game_state) }

            it { is_expected.to be_present }
          end
        end

        context "and we can afford to buy the hotel" do
          let(:can_afford) { true }

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
  end

  describe "applying the event" do
    before do
      expect(game_state).to receive(:current_player).and_return(0)
      expect(game_state).to receive(:players).and_return([player])
    end

    let(:player) { instance_double("Player") }

    it "should purchase the hotel" do
      expect(player).to receive(:purchase_hotel!).with(property)
      event.apply(game_state)
    end
  end
end
