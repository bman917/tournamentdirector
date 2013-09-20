ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...


  def seed_sletba_open
    load "#{Rails.root}/db/seeds/test/sletba_open.seeds.rb"
  end

  def standard_setup
  	puts "Performaing stadrd setup..."

  	seed_sletba_open

    @sletba_open = Tournament.find_by_name('SLETBA OPEN 2013')

  	@squad_entry1 = SquadEntry.find(1)
  	@squad_entry2 = SquadEntry.find(2)
    @squad_entry3 = SquadEntry.find(3)
    @squad_entry4 = SquadEntry.find(4)
    @squad_entry5 = SquadEntry.find(5)
    @squad_entry6 = SquadEntry.find(6)

    @singles = GameType.find_by_name('Singles')
    @class_o = BowlerClass.find_by_name('OPEN')

  end

  def create_squad_entry_for_bowler_juan

    @new_squad_entry_for_bowler_juan = SquadEntry.new(game_type: game_types(:singles))
    @new_squad_entry_for_bowler_juan.add_bowler bowlers(:juan)
    @new_squad_entry_for_bowler_juan.save!
    return @new_squad_entry_for_bowler_juan
    
  end

end