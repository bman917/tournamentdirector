module ApplicationHelper

	def master?
		current_user.role == 'MASTER'
	end

	def admin?
		master? || current_user.role == 'ADMIN'
	end

	def selected_squad
		@selected_squad ||= Squad.find_by_id(session[:selected_squad]) if session[:selected_squad]
	end

	def selected_squad_entry
		@selected_squad_entry ||= SquadEntry.find_by_id(session[:selected_squad_entry]) if session[:selected_squad_entry]
	end


end
