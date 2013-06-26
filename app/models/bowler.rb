class Bowler < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name
  belongs_to :bowling_association
end
