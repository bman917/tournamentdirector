class Game < ActiveRecord::Base
  belongs_to :bowler
  belongs_to :user
end
