class SessionsController < ApplicationController
	skip_before_action :require_login, only: [:new, :create, :destroy]
	
	def new
	end

	def create
	  user = User.authenticate(params[:email], params[:password])
	  if user
	    session[:user_id] = user.id

	    if user.master?
	    	redirect_to root_url
	    elsif user.admin?
	    	redirect_to tournament_select_path(user.tournaments.last)
	    elsif user.encoder?
	    	redirect_to latest_squads_path
	    else
	    	redirect_to latest_tournaments_path
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

	def error
	end

end
