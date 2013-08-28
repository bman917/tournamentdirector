require 'test_helper'

class TournamentTest < ActiveSupport::TestCase

	setup do
		@tournament = tournaments(:one)
	end

	test "All Squads should be deleted when tournament is deleted" do
     	squad1 = @tournament.squads.create(name: "Squad One")
     	@tournament.destroy
     	assert_record_not_found {Squad.find(squad1)}

	end

	def assert_record_not_found(&block)
		assert_raise((ActiveRecord::RecordNotFound), &block )
	end
end
