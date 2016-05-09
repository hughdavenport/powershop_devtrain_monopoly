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

  def logged_in
    unless @current_user
      flash[:danger] = t("Please log in")
      redirect_to :root
    end
  end

  def current_player
    true # TODO do
  end
end
