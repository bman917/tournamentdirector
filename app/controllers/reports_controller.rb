class ReportsController < ApplicationController

  def index
  	clear_selected_squad
  	@bowling_associations = selected_tournament.participating_associations
  end

  def show_ranking
  	@tournament = current_user.tournaments.find(session[:selected_tournament], :include =>:squad_entries)
  	clear_selected_squad
  end

end
