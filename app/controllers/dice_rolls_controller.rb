class DiceRollsController < ApplicationController
  before_action :set_game
  before_action :set_player
  before_action :logged_in

  # POST /games/1/players/1/dice_rolls
  def create
    service = RollDice.new(game: @game, player: @player)

    if service.call
      redirect_to @game, notice: 'Dice rolled'
    else
      redirect_to @game, :alert => {errors: service.errors.full_messages}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:game_id])
    end

    def set_player
      @player = Player.find(params[:player_id])
    end
end
