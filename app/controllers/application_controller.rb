class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_current_user

  private

  def set_current_user
    @current_user = User.find_by_username(params[:user]) if params[:user]
  end

  def default_url_options(options = {})
    options.tap do |options|
      options[:user] = params[:user] if params[:user]
    end
  end

  def logged_in
    unless @current_user
      flash[:danger] = t("Please log in")
      redirect_to :root
    end
  end
end
