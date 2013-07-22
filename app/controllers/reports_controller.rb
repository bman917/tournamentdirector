class ReportsController < ApplicationController
  def show_entries
  	@bowling_association = BowlingAssociation.find(params[:bowling_association_id])
  	@squad_entries = selected_tournament.bowling_association_entries(@bowling_association)
  	#puts "Squad Entries: #{@squad_entries.count}"
  end
end
