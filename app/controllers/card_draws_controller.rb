class CardDrawsController < ApplicationController
  before_action :set_game
  before_action :check_logged_in_or_redirect_root
  before_action :check_current_player_or_redirect_game

  # POST /games/1/card_draws
  def create
    service = DrawCard.new(game: @game, card: (params[:card] if params.include?(:card) && (Rails.env.test? || Rails.env.development?)))

    if service.call
      redirect_to @game, notice: 'Card drawn'
    else
      redirect_to @game, :alert => {errors: service.errors.full_messages}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:game_id])
    end
end
