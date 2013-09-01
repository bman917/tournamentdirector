require 'test_helper'

class SquadEntryTest < ActiveSupport::TestCase

	test "All games should be deleted when squad entry is deleted" do
		bowler = bowlers(:one)
		game = bowler.games.create(score: 100)
		bowler.destroy
		assert_raise(ActiveRecord::RecordNotFound) { Game.find(game) }
	end

	test "Validate insufficient number of players" do
		squad_entry = squad_entries(:one)

		bowlers = [bowlers(:one).id]
		squad_entry.add_bowlers(bowlers)

		assert (squad_entry.valid? == false), "SquadEntry should not be valid if it has insufficient bowlers."
		assert squad_entry.errors.any?, "An error should be added when a SquadEntry has insufficient bowlers."
		
	end


	test "Test no exceptions when adding nil bowler" do
		squad_entry = squad_entries(:one)
		squad_entry.add_bowler("")
		squad_entry.add_bowler(nil)
	end
end
