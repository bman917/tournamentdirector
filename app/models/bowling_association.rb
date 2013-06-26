class BowlingAssociation < ActiveRecord::Base
	has_many :bowlers
	validates :name, presence: true
end
