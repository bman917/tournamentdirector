require 'test_helper'

class SquadEntryTest < ActiveSupport::TestCase

	test "All games should be deleted when squad entry is deleted" do
		bowler = bowlers(:one)
		game = bowler.games.create(score: 100)
		bowler.destroy
		assert_raise(ActiveRecord::RecordNotFound) { Game.find(game) }
	end
end
