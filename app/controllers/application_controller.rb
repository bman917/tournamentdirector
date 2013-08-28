class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :selected_tournament, :logged_in?
  before_action :require_login

  include SessionsHelper

  private
  def user_is_master?
    unless current_user.master?
      flash[:error] = "You are not authorized to do that action"
      redirect_to error_path
    end
  end

  def user_is_admin?
    check_authorization(current_user.admin?)
  end

  def user_is_encoder?
    check_authorization(current_user.encoder?)
  end

  def check_authorization(condition)
    unless condition
      flash[:error] = "You are not authorized to do that action"
      redirect_to error_path
    end      
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    if @current_user == nil
      session[:user_id] = nil
    end
    @current_user
  end

  def selected_tournament
    @selected_tournament ||= current_user.tournaments.find(session[:selected_tournament]) if session[:selected_tournament]
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
