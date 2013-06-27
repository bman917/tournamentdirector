class AverageEntry < ActiveRecord::Base
  belongs_to :bowler
  belongs_to :user
  validates :average, numericality: { only_integer: true }
end
