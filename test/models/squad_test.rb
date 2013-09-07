require 'test_helper'

class SquadTest < ActiveSupport::TestCase

	setup do
        seed_sletba_open
    	@squad = squads(:one)
	end


	test "Squad counter cache for squad_entries" do

        @squad.squad_entries.clear
        assert_equal 0, @squad.squad_entries.size

        @squad.squad_entries << create_squad_entry_for_bowler_juan
        @squad.squad_entries << create_squad_entry_for_bowler_juan
        @squad.squad_entries << create_squad_entry_for_bowler_juan
        @squad.squad_entries << create_squad_entry_for_bowler_juan
        @squad.squad_entries << create_squad_entry_for_bowler_juan

		@squad.save!
		#the test will fail without this extra call. This is clearly a bug in rails
		@squad.squad_entries.size


		assert_equal 5, @squad.squad_entries.size, "@squad.squad_entries.size should be 5 and not #{@squad.squad_entries.size}"

	end

	test "Test get Squad Entries with no games" do

        se1 = create_squad_entry_for_bowler_juan
        se2 = create_squad_entry_for_bowler_juan
        se3 = create_squad_entry_for_bowler_juan
        se4 = create_squad_entry_for_bowler_juan
        se5 = create_squad_entry_for_bowler_juan

        se1.games.create(score: 100)
        se2.games.create(score: 100)
        se3.games.create(score: 100)

        @squad.squad_entries.clear
		
    	@squad.squad_entries << se1
    	@squad.squad_entries << se2
    	@squad.squad_entries << se3
    	@squad.squad_entries << se4
    	@squad.squad_entries << se5
    	
    	assert_equal 2, @squad.pending.size, "Incorrect number of pending entries"
    end
end
