class ReportsController < ApplicationController

  def index
  	clear_selected_squad
  	@bowling_associations = selected_tournament.participating_associations
  end

  def show_ranking
  	clear_selected_squad
  end

end
