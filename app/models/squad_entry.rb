class SquadEntry < ActiveRecord::Base
  has_and_belongs_to_many :bowlers
  belongs_to :squad
end
