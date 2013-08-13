module SessionsHelper
	
	def clear_selected_tournament
	  session[:selected_tournament] = nil
	  clear_selected_squad
	end

	def clear_selected_squad
      session[:selected_squad] = nil
      session[:selected_squad_entry] = nil
  	end

	def set_selected_tournament(tournament)
		clear_selected_tournament
		session[:selected_tournament] = tournament.id
	end

	def set_selected_squad(squad)
		set_selected_tournament(squad.tournament)
		session[:selected_squad] = squad.id
	end

	def set_selected_squad_entry(squad_entry)
		set_selected_squad(squad_entry.squad)
		session[:selected_squad_entry] = squad_entry.id
	end

end
