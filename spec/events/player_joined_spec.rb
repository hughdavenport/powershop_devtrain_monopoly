require 'rails_helper'

RSpec.describe PlayerJoined, type: :event do
  let(:game_state) do
    instance_double("GameState").tap do |game_state|

    end
  end

  subject(:event) { PlayerJoined.new(piece: piece, user: user_id) }

  let(:piece) { "wheelbarrow" }
  let(:user_id) { 1 }

  describe "checking validity" do
    context "when I have an invalid piece" do
      let(:piece) { "invalid" }

      describe "#can_apply?" do
        subject { event.can_apply?(game_state) }

        it { is_expected.to be_falsey }
      end

      describe "#errors" do
        before do
          allow(game_state).to receive(:started?).and_return(true)
          allow(game_state).to receive(:player_with_piece).with(piece).and_return(nil)
          allow(game_state).to receive(:player).with(user_id).and_return(nil)
        end

        subject { event.errors(game_state) }

        it { is_expected.to be_present }
      end
    end

    context "when I have a valid piece" do
      before do
        expect(game_state).to receive(:started?).and_return(started)
      end

      context "when the game is already started" do
        let(:started) { true }

        describe "#can_apply?" do
          subject { event.can_apply?(game_state) }

          it { is_expected.to be_falsey }
        end

        describe "#errors" do
          before do
            allow(game_state).to receive(:player_with_piece).with(piece).and_return(nil)
            allow(game_state).to receive(:player).with(user_id).and_return(nil)
          end

          subject { event.errors(game_state) }

          it { is_expected.to be_present }
        end
      end

      context "when the game is not yet started" do
        let(:started) { false }

        before do
          expect(game_state).to receive(:player_with_piece).with(piece).and_return(player_with_piece)
        end

        context "which another player already has the same piece" do
          let(:player_with_piece) { "player" }

          describe "#can_apply?" do
            subject { event.can_apply?(game_state) }

            it { is_expected.to be_falsey }
          end

          describe "#errors" do
            before do
              expect(game_state).to receive(:player).with(user_id).and_return(nil)
            end

            subject { event.errors(game_state) }

            it { is_expected.to be_present }
          end
        end

        context "when no another player has the same piece" do
          let(:player_with_piece) { nil }

          before do
            expect(game_state).to receive(:player).with(user_id).and_return(player)
          end

          context "which I have already joined" do
            let(:player) { "player" }

            describe "#can_apply?" do
              subject { event.can_apply?(game_state) }

              it { is_expected.to be_falsey }
            end

            describe "#errors" do
              subject { event.errors(game_state) }

              it { is_expected.to be_present }
            end
          end

          context "and I can join" do
            let(:player) { nil }

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
  end

  describe "applying the event" do
    before do
      class_double("Player").as_stubbed_const.tap do |klazz|
        expect(klazz).to receive(:new).with(user: user_id, piece: piece).and_return(new_player)
      end
      expect(game_state).to receive(:current_player).and_return(current_player)
      expect(game_state).to receive(:players).and_return(players)
    end

    let(:players) do
      double("Players").tap do |players|
        expect(players).to receive(:<<).with(new_player)
      end
    end

    let(:new_player) { instance_double("Player") }

    context "as the first player" do
      let(:current_player) { nil }

      it "should set the current player" do
        expect(game_state).to receive(:current_player=).with(0)
        event.apply(game_state)
      end
    end

    context "not as the first player" do
      let(:current_player) { 0 }

      it "should not set the current player" do
        expect(game_state).not_to receive(:current_player=)
        event.apply(game_state)
      end
    end
  end
end
