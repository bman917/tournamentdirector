class ReportsController < ApplicationController

  def index
  	@bowling_associations = selected_tournament.participating_associations
  end

  def show_entries
  	@bowling_association = BowlingAssociation.find(params[:bowling_association_id])
  	#@squad_entries = selected_tournament.bowling_association_entries(@bowling_association)
  	#puts "Squad Entries: #{@squad_entries.count}"
  	@bowlers = selected_tournament.bowlers(@bowling_association)

  end

  def show_bowler_entries
  	@bowler = Bowler.find(params[:bowler_id])
  	@squad_entries = @bowler.get_tournament_entries(selected_tournament)
  end

end
