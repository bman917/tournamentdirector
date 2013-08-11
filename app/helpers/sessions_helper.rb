module SessionsHelper
	
	def clear_selected_tournament
	  session[:selected_tournament] = nil
      session[:selected_squad] = nil
      session[:selected_squad_entry] = nil
	end

	def set_selected_tournament(tournament)
		session[:selected_tournament] = tournament.id
	end

end
