class AllEventsController < ApplicationController
	def index

		@all_events = AllEvent.where(tournament: selected_tournament)

	end
end
