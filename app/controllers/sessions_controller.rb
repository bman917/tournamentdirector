class SessionsController < ApplicationController
	skip_before_action :require_login, only: [:new, :create, :destroy]
	
	def new
	end

	def create
	  user = User.authenticate(params[:email], params[:password])
	  if user
	    session[:user_id] = user.id

	    if user.admin?
	    	redirect_to root_url, :notice => "Logged in!"
	    else
	    	redirect_to tournament_latest_path
	    end


	  else
	    flash.now.alert = "Invalid email or password"
	    render "new"
	  end
	end

	def destroy
	  session[:user_id] = nil
	  session[:selected_tournament] = nil
	  session[:selected_squad] = nil
	  session[:selected_squad_entry] = nil

	  redirect_to root_url, :notice => "Logged out!"
	end

end
