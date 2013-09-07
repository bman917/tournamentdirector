require 'test_helper'

class TournamentTest < ActiveSupport::TestCase

	setup do
		seed_sletba_open
		@tournament = tournaments(:sletba_open)

	end

	test "All Squads should be deleted when tournament is deleted" do

		@tournament.squads.clear
     	squad1 = @tournament.squads.create(name: "Squad One")
     	assert_equal 1, @tournament.squads.size

     	@tournament.destroy
     	assert_record_not_found {Squad.find(squad1)}
     	assert_equal 0, @tournament.squads.size

	end

	def assert_record_not_found(&block)
		assert_raise((ActiveRecord::RecordNotFound), &block )
	end
end
