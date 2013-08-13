class ReportsController < ApplicationController

  def index
  	@bowling_associations = selected_tournament.participating_associations
  end

  def show_ranking
  end

end
