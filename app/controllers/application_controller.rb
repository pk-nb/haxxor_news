class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user
  before_action :store_current_url


  private
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def current_user=(user)
    @current_user= user
    session[:user_id] = @current_user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def store_current_url
    session[:current_url] = request.original_url
  end

  def current_url
    session[:current_url]
  end
end
