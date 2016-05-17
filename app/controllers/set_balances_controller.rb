class SetBalancesController < ApplicationController
  before_action :set_game
  before_action :check_logged_in_or_redirect_root
  before_action :check_current_player_or_redirect_game
  before_action :check_in_development_mode_or_redirect_game

  # POST /games/1/set_balances
  def create
    @game.events << BalanceSet.new(amount: params[:amount])
    redirect_to @game
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:game_id])
    end

    def check_in_development_mode_or_redirect_game
      unless Rails.env.development? || Rails.env.test?
        flash[:danger] = 'TESTING FEATURE ONLY!'
        redirect_to @game
      end
    end
end
