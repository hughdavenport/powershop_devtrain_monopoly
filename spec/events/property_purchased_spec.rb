require 'rails_helper'

RSpec.describe PropertyPurchased, type: :event do
  let(:game_state) do
    instance_double("GameState").tap do |game_state|

    end
  end

  subject(:event) { PropertyPurchased.new }

  let(:amount) { nil }

  describe "checking validity" do
    before do
      expect(game_state).to receive(:can_buy_property?).and_return(can_buy_property)
    end

    context "when there isn't a property to buy" do
      let(:can_buy_property) { false }

      describe "#can_apply?" do
        subject { event.can_apply?(game_state) }

        it { is_expected.to be_falsey }
      end

      describe "#errors" do
        before do
          expect(game_state).to receive(:current_player).and_return(0)
          expect(game_state).to receive(:players).and_return([player])
          expect(game_state).to receive(:board).and_return(board)
          expect(game_state).to receive(:details).with(board).and_return(details)
        end

        let(:board) do
          double("Board").tap do |board|
            expect(board).to receive(:[]).with(location).and_return(board)
          end
        end

        let(:player) do
          {
            money: money,
            location: location,
          }
        end

        let(:location) { 15 }

        let(:details) do
          {
            price: price,
          }
        end

        let(:price) { 50 }
        let(:money) { 60 }

        subject { event.errors(game_state) }

        it { is_expected.to be_present }
      end
    end

    context "when we can buy the current property" do
      let(:can_buy_property) { true }

      before do
        expect(game_state).to receive(:current_player).and_return(0)
        expect(game_state).to receive(:players).and_return([player])
        expect(game_state).to receive(:board).and_return(board)
        expect(game_state).to receive(:details).with(board).and_return(details)
      end

      let(:board) do
        double("Board").tap do |board|
          expect(board).to receive(:[]).with(location).and_return(board)
        end
      end

      let(:player) do
        {
          money: money,
          location: location,
        }
      end

      let(:location) { 15 }

      let(:details) do
        {
          price: price,
        }
      end

      let(:price) { 50 }

      context "but we can't afford to buy the property" do
        let(:money) { 10 }

        describe "#can_apply?" do
          subject { event.can_apply?(game_state) }

          it { is_expected.to be_falsey }
        end

        describe "#errors" do
          subject { event.errors(game_state) }

          it { is_expected.to be_present }
        end
      end

      context "and we can afford to buy the property" do
        let(:money) { 60 }

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

  describe "applying the event" do
    before do
      expect(game_state).to receive(:current_player).and_return(0)
      expect(game_state).to receive(:players).and_return([player])
      expect(game_state).to receive(:board).and_return(board)
    end

    let(:board) do
      double("Board").tap do |board|
        expect(board).to receive(:[]).with(location).and_return(property)
      end
    end

    let(:property) { double("Property") }

    let(:player) do
      {
        location: location
      }
    end

    let(:location) { 25 }

    it "should purchase the property" do
      expect(game_state).to receive(:purchase_property!).with(player, property)
      event.apply(game_state)
    end
  end
end
