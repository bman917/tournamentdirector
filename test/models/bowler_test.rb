require 'test_helper'

class BowlerTest < ActiveSupport::TestCase

	setup do
		seed_sletba_open
		@bowler_one = bowlers(:juan)
	end

	test "Do not allow duplicate name" do
		Bowler.new(name: 'Bowler One').save
		assert(Bowler.new(name: 'Bowler One').save == false, "Duplicate bowler name should not be allowed.")
	end

	test "Bowler delete" do
		@bowler_one.destroy
		assert_record_not_found { Bowler.find(@bowler_one) }
	end

	test "All bowler Games should be deleted when bowler is deleted" do
		game = @bowler_one.games.create(score: 100)
		@bowler_one.destroy
		assert_record_not_found { Game.find(game) }
	end

	test "All bowler average entries should be deleted when bowler is deleted" do
		average = @bowler_one.average_entries.create(average: 100)
		@bowler_one.destroy
		assert_record_not_found { AverageEntry.find(average)}
	end

	test "Squad entry should be deleted when bowler is deleted" do
		
		@bowler_one.squad_entries.clear
		squad_entry = create_squad_entry_for_bowler_juan

		@bowler_one.destroy
		
		squad_entry.reload
		assert_equal 0, squad_entry.bowlers.size
	end

	test 'Bowler with dublicate name not allowed' do
		b1 = Bowler.create(name: 'Test Duplicate',   last_name: 'Test Duplicate', gender: 'M')
		b1.save!

		b2 = Bowler.create(name: 'Test Duplicate',   last_name: 'Test Duplicate', gender: 'M')
		assert b2.invalid?, 'Bowler with duplicate full name should not be allowed.'

    end

    test 'Bowler Full Name has no double white space' do
    	b1 = Bowler.create(name: 'First Name',   last_name: 'Last   Name', gender: 'M')
    	assert_equal 'First Name Last Name', b1.full_name

    	b1 = Bowler.create(name: 'First', middle_name: 'Middle', last_name: 'Last', gender: 'M')
    	assert_equal 'First Middle Last', b1.full_name
    end

	def assert_record_not_found(&block)
		assert_raise((ActiveRecord::RecordNotFound), &block )
	end
end
