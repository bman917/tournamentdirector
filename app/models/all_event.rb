class AllEvent < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :bowler
  has_and_belongs_to_many :squad_entries
  belongs_to :bowler_class
end
