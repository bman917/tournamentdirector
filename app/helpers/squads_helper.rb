module SquadsHelper

	def hide?(squad_entry)
		squad_entry.category != session[:bowler_class_name] || squad_entry.game_type.name != session[:game_type_name]
	end

	def css(squad_entry)
		css = "#{squad_entry.category_css} #{to_css(squad_entry.game_type.name)} "
		css += "hidden" if hide?(squad_entry)
		css += "updated" if flash[:updated_squad_entry_id] == squad_entry.id
		css
	end

	 def to_css(string)
	    s = String.new(string)
	    s.gsub!(/\s+/, "")
	    s
	 end

end
