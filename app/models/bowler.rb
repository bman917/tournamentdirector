class Bowler < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :bowling_association
end
