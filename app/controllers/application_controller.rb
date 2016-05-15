class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_current_user

  private

  def set_current_user
    @current_user = User.find_by_username(params[:username]) if params[:username]
  end

  def default_url_options(options = {})
    options.tap do |options|
      options[:username] = params[:username] if params[:username]
    end
  end

  def check_logged_in_or_redirect_root
    unless @current_user
      flash[:danger] = t("Please log in")
      redirect_to :root
    end
  end

  def check_current_player_or_redirect_game
    check_logged_in_or_redirect_root
    unless @game
      flash[:danger] = t('Developer error')
      # Shouldn't happen, controller shouldn't request this unless nested below a game
      redirect_to :root
    end
    unless @game.state.players[@game.state.current_player] == @game.state.player(@current_user.id)
      flash[:danger] = 'Not your turn'
      redirect_to @game
    end
  end
end
