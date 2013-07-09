class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :selected_tournament, :logged_in?
  before_action :require_login
 
  private

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    if @current_user == nil
      session[:user_id] = nil
    end
    @current_user
  end

  def selected_tournament
    @selected_tournament ||= Tournament.find_by_id(session[:selected_tournament]) if session[:selected_tournament]
  end


  def logged_in?
  	session[:user_id]
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to log_in_path # halts request cycle
    end
  end

end
