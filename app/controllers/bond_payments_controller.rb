class BondPaymentsController < ApplicationController
  before_action :set_game
  before_action :check_logged_in_or_redirect_root
  before_action :check_current_player_or_redirect_game
  before_action :check_expecting_roll_or_redirect_game

  # POST /games/1/bond_paymetns
  def create
    service = PayBond.new(game: @game)

    if service.call
      redirect_to @game, notice: 'Bond paid'
    else
      redirect_to @game, :alert => {errors: service.errors.full_messages}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:game_id])
    end

    def check_expecting_roll_or_redirect_game
      if @game.state.expecting_rolls < 2
        flash[:danger] = 'Already rolled'
        redirect_to @game
      end
    end
end
