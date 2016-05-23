require 'rails_helper'

def expect_service_called(service_name, with = no_args)
  service = instance_double(service_name).tap do |service|
    expect(service).to receive(:call).with(no_args)
  end
  class_double(service_name).as_stubbed_const.tap do |klass|
    expect(klass).to receive(:new).with(with).and_return(service)
  end
end

RSpec.describe CreateGame, type: :service do
  let(:game) do
    instance_double("Game").tap do |game|
      expect(game).to receive(:save).and_return(can_apply)
      allow(game).to receive(:errors).and_return(errors)
    end
  end

  before do
    class_double("Game").as_stubbed_const.tap do |klazz|
      expect(klazz).to receive(:new).with(number_of_players: number_of_players).and_return(game)
    end
    expect_service_called("ShuffleChanceCards", game: game)
    expect_service_called("ShuffleCommunityChestCards", game: game)
  end

  subject(:service) { CreateGame.new(number_of_players: number_of_players) }

  let(:number_of_players) { 2 }

  context "when the game state is valid" do
    let(:can_apply) { true }
    let(:errors) { [] }

    describe "#call" do
      it "succeeds" do
        expect(service.call).to be_truthy
      end
    end

    describe "#errors" do
      let(:errors) { [] }

      it "should not return errors" do
        service.call
        expect(service.errors).not_to be_present
      end
    end

    describe "#game" do
      it "returns the given value" do
        service.call
        expect(service.game).to be game
      end
    end
  end

  context "when the game state is invalid" do
    let(:can_apply) { false }
    let(:errors) { ["error"] }

    describe "#call" do
      it "fails" do
        expect(service.call).to be_falsey
      end
    end

    describe "#errors" do
      let(:errors) { [1] }

      it "should return errors" do
        service.call
        expect(service.errors).to be errors
      end
    end

    describe "#game" do
      it "returns the given value" do
        service.call
        expect(service.game).to be game
      end
    end
  end
end
