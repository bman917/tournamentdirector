class GameType < ActiveRecord::Base
	has_and_belongs_to_many :tournaments, uniq: true


	def list_tournaments

	end
end
