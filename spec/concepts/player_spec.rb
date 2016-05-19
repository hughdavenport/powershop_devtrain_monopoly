require 'rails_helper'

RSpec.describe Player, type: :concept do
  describe "#initialize" do
    let(:user) { "user" }
    let(:piece) { "piece" }

    subject(:player) { Player.new(user: user, piece: piece) }

    it "should have the right user" do
      expect(player.user).to eq user
    end

    it "should have the right piece" do
      expect(player.piece).to eq piece
    end

    it "should have a starting balance of $1500" do
      expect(player.money).to eq 1500
    end

    it "should have a starting location of Go" do
      expect(player.location).to eq 0
    end

    it "should not be in jail initially" do
      expect(player.jail?).to be_falsey
    end

    it "should have no dice rolls initially" do
      expect(player.dice_rolls).to be_empty
    end

    it "should have no doubles in a row initially" do
      expect(player.doubles_in_a_row).to eq 0
    end

    it "should have no pairs rolled while in jail initially" do
      expect(player.pairs_rolled_while_in_jail).to eq 0
    end

    it "should have no properties initially" do
      expect(player.properties).to be_empty
    end
  end
end
