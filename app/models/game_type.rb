class GameType < ActiveRecord::Base
	has_and_belongs_to_many :tournaments, uniq: true


	def to_s
		name
	end

	def total_games
		(number_of_players * number_of_games)
	end
end