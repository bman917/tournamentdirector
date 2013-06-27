class Tournament < ActiveRecord::Base
  belongs_to :bowling_association
  has_many :squads
end
