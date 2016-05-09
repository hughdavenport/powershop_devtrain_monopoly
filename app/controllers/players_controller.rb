class PlayersController < ApplicationController
  before_action :set_game
  before_action :set_game_state
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :logged_in

  # GET /games/1/players
  def index
    @players = @game_state.players
  end

  # GET /games/1/players/1
  def show
  end

  # GET /games/1/players/new
  def new
    redirect_to game_players_path, notice: 'You are already playing' if @game_state.players.include? @current_user.id
  end

  # GET /games/1/players/1/edit
  def edit
  end

  # POST /games/1/players
  def create
    service = AddPlayerToGame.new(game: @game, user: @current_user, piece: player_piece)

    if service.call
      redirect_to @game, notice: 'Player was successfully created.'
    else
      redirect_to @game, :alert => {errors: service.errors.full_messages}
    end
  end

  # PATCH/PUT /games/1/players/1
  def update
    if @player.update(player_params)
      redirect_to @game, notice: 'Player was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /games/1/players/1
  def destroy
    @player.destroy
    redirect_to game_players_url(@game), notice: 'Player was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:game_id])
    end

    def set_game_state
      @game_state = @game.state
    end

    def set_player
      @player = Player.find(params[:id])
    end

    def player_piece
      params[:piece]
    end
end
