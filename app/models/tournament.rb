class Tournament < ActiveRecord::Base
  belongs_to :bowling_association
  has_many :squads
  has_many :users

  def to_s
  	name
  end
end
