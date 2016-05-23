class GamesController < ApplicationController
  before_action :set_game, only: [:show, :destroy]
  before_action :set_game_state, only: [:show]
  before_action :check_logged_in_or_redirect_root

  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/1
  def show
    redirect_to game_players_path(@game) if @game_state.players.count != @game.number_of_players
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # POST /games
  def create
    @service = CreateGame.new(number_of_players: game_params[:number_of_players])

    if @service.call
      redirect_to @service.game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    def set_game_state
      @game_state = @game.state
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:number_of_players)
    end
end
