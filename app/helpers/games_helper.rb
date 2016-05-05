module GamesHelper
  def current_game_player
    @game.players.find_by_user_id(@current_user.id)
  end
end
