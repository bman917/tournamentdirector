class AddTournamentRefToActivities < ActiveRecord::Migration
  def change
    add_reference :activities, :tournament, index: true
  end
end
