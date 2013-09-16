class ActivitiesController < ApplicationController

  before_action	:user_is_admin?

	def index

		@activities = PublicActivity::Activity.all.order("created_at desc").includes(:owner).includes(:trackable)

		unless current_user.master?
			@activities = @activities.where(tournament_id: selected_tournament)
		end

		@activities = @activities.paginate(page: params[:page])
	end
end
