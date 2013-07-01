class BowlingAssociation < ActiveRecord::Base
	has_many :bowlers
	validates :name, presence: true
	validates_uniqueness_of :name

	def to_s
		name
	end

end
