require 'test_helper'

class SquadTest < ActiveSupport::TestCase

	setup do
    	@se1 = squad_entries(:one)
    	@se2 = squad_entries(:two)
    	@se3 = squad_entries(:three)
    	@se4 = squad_entries(:four)
    	@se5 = squad_entries(:five)

    	@squad = squads(:one)

    	@bowler = bowlers(:one)
    	@se1.bowlers << @bowler
    	@se2.bowlers << @bowler
    	@se3.bowlers << @bowler
    	@se4.bowlers << @bowler
    	@se5.bowlers << @bowler
	end


	test "Squad counter cache for squad_entries" do

		@squad.squad_entries << @se1
		@squad.squad_entries << @se2
		@squad.squad_entries << @se3
		@squad.squad_entries << @se4
		@squad.squad_entries << @se5
		@squad.save!
		#the test will fail without this extra call. This is clearly a bug in rails
		@squad.squad_entries.size


		assert_equal 5, @squad.squad_entries.size, "@squad.squad_entries.size should be 5 and not #{@squad.squad_entries.size}"

	end

	test "Test get Squad Entries with no games" do
		

    	@se1.games.create(score: 100)
    	@se2.games.create(score: 100)
    	@se3.games.create(score: 100)

    	@squad.squad_entries << @se1
    	@squad.squad_entries << @se2
    	@squad.squad_entries << @se3
    	@squad.squad_entries << @se4
    	@squad.squad_entries << @se5
    	
    	assert_equal 2, @squad.pending.size, "Incorrect number of pending entries"
    end
end
