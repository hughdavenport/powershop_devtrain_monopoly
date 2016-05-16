class EndTurnsController < ApplicationController
  before_action :set_game
  before_action :check_logged_in_or_redirect_root
  before_action :check_current_player_or_redirect_game
  before_action :check_can_buy_property_or_redirect_game

  # POST /games/1/end_turns
  def create
    service = EndTurn.new(game: @game)

    if service.call
      redirect_to @game, notice: 'Turn ended'
    else
      redirect_to @game, :alert => {errors: service.errors.full_messages}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:game_id])
    end

    def check_can_buy_property_or_redirect_game
      unless @game.state.can_buy_property?
        flash[:danger] = 'Cannot buy property'
        redirect_to @game
      end
    end
end
