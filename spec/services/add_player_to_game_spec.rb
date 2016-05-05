require 'rails_helper'

RSpec.describe AddPlayerToGame, type: :service do
  let(:game_params) { { number_of_players: 2 } }
  let(:game) { Game.create!(game_params) }

  let(:user) { User.create!(username: "user") }
  let(:piece) { "wheelbarrow" }

  subject(:service) { AddPlayerToGame.new(game: game, user: user, piece: piece) }

  context "when I have a game waiting on 2 players" do

    describe "adding a player" do
      it "succeeds" do
        expect(service.call).to be_truthy
      end

      it "adds a player" do
        expect { service.call }.to change(Player, :count).by(1)
      end

      it "adds the player to the correct game" do
        service.call
        expect(Player.last.game).to eql game
      end

      it "adds the player with the correct values" do
        service.call
        expect(Player.last.user).to eql user
        expect(Player.last.piece).to eql piece
      end

      it "has no errors" do
        service.call
        expect(service.errors).not_to be_present
      end
    end
  end

  context "when I have a game waiting on one more player" do
    before { AddPlayerToGame.new(game: game, user: firstuser, piece: firstpiece).call }

    let(:firstuser) { User.create!(username: "firstuser") }

    describe "adding another user with the same piece" do
      let(:firstpiece) { piece }

      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another player" do
        expect { service.call }.not_to change(Player, :count)
      end

      it "has errors" do
        service.call
        expect(service.errors).to be_present
      end
    end

    describe "adding another user with a different piece" do
      let(:firstpiece) { "dog" }

      it "succeeds" do
        expect(service.call).to be_truthy
      end

      it "adds a player" do
        expect { service.call }.to change(Player, :count).by(1)
      end

      it "adds the player to the correct game" do
        service.call
        expect(Player.last.game).to eql game
      end

      it "adds the player with the correct values" do
        service.call
        expect(Player.last.user).to eql user
        expect(Player.last.piece).to eql piece
      end

      it "has no errors" do
        service.call
        expect(service.errors).not_to be_present
      end
    end
  end

  skip "Can't test invalid enums, see bug https://github.com/rails/rails/issues/13971" do
  #context "when I have an invalid piece" do
    let(:piece) { "invalid" }

    describe "adding a player" do
      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another player" do
        expect { service.call }.not_to change(Player, :count)
      end

      it "has errors" do
        service.call
        expect(service.errors).to be_present
      end
    end
  end

  context "when I have a game that is full" do
    before { AddPlayerToGame.new(game: game, user: firstuser, piece: firstpiece).call }
    before { AddPlayerToGame.new(game: game, user: seconduser, piece: secondpiece).call }

    let(:firstuser) { User.create!(username: "firstuser") }
    let(:firstpiece) { "dog" }
    let(:seconduser) { User.create!(username: "seconduser") }
    let(:secondpiece) { "hat" }

    describe "adding another player" do
      it "fails" do
        expect(service.call).to be_falsey
      end

      it "doesn't add another player" do
        expect { service.call }.not_to change(Player, :count)
      end

      it "has errors" do
        service.call
        expect(service.errors).to be_present
      end
    end
  end
end
