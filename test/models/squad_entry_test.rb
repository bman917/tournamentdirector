require 'test_helper'

class SquadEntryTest < ActiveSupport::TestCase

	setup do
		seed_sletba_open

		@first_squad = Squad.first
		@open_masters = BowlerClass.find(5)

		@new_squad_entry_for_bowler_juan = create_squad_entry_for_bowler_juan
	end

	test "All events total pinfall is updated" do
		bowler1 = Bowler.create(name: 'Bowler1 ',   last_name: 'Bowler', gender: 'M', bowling_association_id: 1)
		bowler2 = Bowler.create(name: 'Bowler2',   last_name: 'Bowler', gender: 'M', bowling_association_id: 1)

		first_singles_entry = create_singles_entry_and_verify_all_events(bowler1)

		game1 = first_singles_entry.add_game(bowler: bowler1, score: 100, hdcp: 0)
		game2 = first_singles_entry.add_game(bowler: bowler1, score: 100, hdcp: 0)
		game3 = first_singles_entry.add_game(bowler: bowler1, score: 100, hdcp: 7)

		bowler1_all_events = bowler1.get_tournament_all_event_entry(@first_squad.tournament)
		assert_equal 307, bowler1_all_events.total_pinfalls

		doubles_entry1 = create_doubles_entry_and_verify_all_events(bowler1, bowler2)
		doubles_entry1.add_game(bowler: bowler1, score: 200)
		doubles_entry1.add_game(bowler: bowler1, score: 200)
		doubles_entry1.add_game(bowler: bowler2, score: 100)
		doubles_entry1.add_game(bowler: bowler2, score: 100)

		bowler1_all_events.reload
		assert_equal 707, bowler1_all_events.total_pinfalls
		bowler2_all_events = bowler2.get_tournament_all_event_entry(@first_squad.tournament)
        assert_equal 200, bowler2_all_events.total_pinfalls

        first_singles_entry.reload
        first_singles_entry.games.clear

        bowler1_all_events.reload
        assert_equal 400, bowler1_all_events.total_pinfalls
	end

	test "Create Add Squad Entry to AllEvents if this is the first entry type for a bowler" do
		
		bowler1 = Bowler.create(name: 'Bowler1 ',   last_name: 'Bowler', gender: 'M', bowling_association_id: 1)
		bowler2 = Bowler.create(name: 'Bowler2',   last_name: 'Bowler', gender: 'M', bowling_association_id: 1)
		
		#First Test - create the first singles entry
		first_singles_entry = create_singles_entry_and_verify_all_events(bowler1)

		#2nd Test - create another singles entry. It should not be added
		another_singles_entry = @first_squad.add_entry([bowler1], game_type_id: 1, category: @open_masters.name)
		bowler1_all_events = bowler1.get_tournament_all_event_entry(@first_squad.tournament)
		assert_equal(nil, bowler1_all_events.squad_entries.exists?(another_singles_entry), "All Events should only contain one singles entry")

		#3rd Test - create a doubles entry.
		doubles_entry1 = create_doubles_entry_and_verify_all_events(bowler1, bowler2)

		#4th Test - create a singles entry for bowler2
		bowler2_singles_entry = create_singles_entry_and_verify_all_events(bowler2)
		
		#5th Test - test that the squad entry is removed from all events if it is deleted
		bowler2_singles_entry.destroy
		bowler2_all_events = bowler2.get_tournament_all_event_entry(@first_squad.tournament)
		assert_equal 1, bowler2_all_events.squad_entries.size

		#6th Test - verify that squad entries are not deleted when all events is deleted.
		bowler2_all_events.destroy
		#this call should not raise any exceptions
		SquadEntry.find(doubles_entry1)
	end

	test "Do not delete an AllEvent when it still has one entry" do
		bowler1 = Bowler.create(name: 'Bowler1 ',   last_name: 'Bowler', gender: 'M', bowling_association_id: 1)
        bowler2 = Bowler.create(name: 'Bowler2',   last_name: 'Bowler', gender: 'M', bowling_association_id: 1)

		singles_entry = create_singles_entry_and_verify_all_events(bowler1)
		doubes_entry  = create_doubles_entry_and_verify_all_events(bowler1, bowler2)

		bowler1_all_events = bowler1.get_tournament_all_event_entry(@first_squad.tournament)

		assert_equal 2, bowler1_all_events.squad_entries.size

		doubes_entry.destroy

		bowler1_all_events.reload
		assert_equal 1, bowler1_all_events.squad_entries.size

	end

	def create_singles_entry_and_verify_all_events(bowler)
		first_singles_entry = @first_squad.add_entry([bowler], game_type_id: 1, category: @open_masters.name)
		all_event = bowler.get_tournament_all_event_entry(@first_squad.tournament)
		assert(all_event != nil, "AllEvents should have been created for a bowler's 1st squad entry")
		assert(all_event.squad_entries.exists?(first_singles_entry), 'bowler1 should have a singels all events entry')
		return first_singles_entry
	end

	def create_doubles_entry_and_verify_all_events(bowler1, bowler2)

		doubles_entry1 = @first_squad.add_entry([bowler1, bowler2], game_type_id: 2, category: @open_masters.name)

		bowler2_all_events = bowler2.get_tournament_all_event_entry(@first_squad.tournament)
		bowler1_all_events = bowler1.get_tournament_all_event_entry(@first_squad.tournament)

		puts "Test Result: Bowler1: #{bowler1_all_events.squad_entries.size}, Bowler2: #{bowler2_all_events.squad_entries.size}"

		assert bowler2_all_events.squad_entries.exists?(doubles_entry1), "bowler2 should have a doubles all events entry"
		assert bowler1_all_events.squad_entries.exists?(doubles_entry1), "bowler1 should have a doubles all events entry"

		return doubles_entry1
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

	test "Test adding bowler using full name" do
		bowler = bowlers(:juan)
		full_name = bowler.full_name
		squad_entry = SquadEntry.new(game_type: game_types(:singles))
		squad_entry.add_bowler(full_name)
		squad_entry.save!
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
