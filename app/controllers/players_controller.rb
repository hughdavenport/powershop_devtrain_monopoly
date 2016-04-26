class PlayersController < ApplicationController
  before_action :set_game
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /games/1/players
  # GET /games/1/players.json
  def index
    @players = @game.players.all
  end

  # GET /games/1/players/1
  # GET /games/1/players/1.json
  def show
  end

  # GET /games/1/players/new
  def new
    @player = @game.players.new
  end

  # GET /games/1/players/1/edit
  def edit
  end

  # POST /games/1/players
  # POST /games/1/players.json
  def create
    @player = @game.players.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to game_player_url(@game, @player), notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1/players/1
  # PATCH/PUT /games/1/players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to game_player_url(@game, @player), notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: game_player_url(@game, @player) }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1/players/1
  # DELETE /games/1/players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to game_players_url(@game), notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:game_id])
    end

    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:piece)
    end
end
