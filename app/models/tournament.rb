class Tournament < ActiveRecord::Base
  belongs_to :bowling_association
  has_many :squads, dependent: :destroy
  has_and_belongs_to_many :users
  has_and_belongs_to_many :game_types, uniq: true


  def to_s
  	name
  end
end
