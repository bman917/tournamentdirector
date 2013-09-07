require 'test_helper'

class SquadEntryTest < ActiveSupport::TestCase

	setup do
		seed_sletba_open

		@new_squad_entry_for_bowler_juan = create_squad_entry_for_bowler_juan
	end

	test "All games should be deleted when squad entry is deleted" do
		
		bowler = bowlers(:juan)
		game = bowler.games.create(score: 100)
		bowler.destroy
		assert_raise(ActiveRecord::RecordNotFound) { Game.find(game) }
	end

	test "Validate insufficient number of players" do
		squad_entry = SquadEntry.new(game_type: game_types(:doubles))
		bowlers = [bowlers(:juan).id]
		squad_entry.add_bowlers(bowlers)

		assert (squad_entry.valid? == false), "SquadEntry should not be valid if it has insufficient bowlers."
		assert squad_entry.errors.any?, "An error should be added when a SquadEntry has insufficient bowlers."
		
	end


	test "Test no exceptions when adding nil bowler" do
		squad_entry = squad_entries(:one)
		squad_entry.add_bowler("")
		squad_entry.add_bowler(nil)
	end


	test "SquadEntry Game counter cache" do
		@new_squad_entry_for_bowler_juan
		@new_squad_entry_for_bowler_juan.games.create(score: 100)
		
		assert_equal 1, @new_squad_entry_for_bowler_juan.games.size
	end

	test "Validate that Tournament is linked when SquadEntry is created with a squad" do
		squad = squads(:one)
		@new_squad_entry_for_bowler_juan.squad = squad
		@new_squad_entry_for_bowler_juan.save!

		assert squad.tournament.squad_entries.exists?(@new_squad_entry_for_bowler_juan), "Squad Entry did not get linked to tournament"
	end
end
