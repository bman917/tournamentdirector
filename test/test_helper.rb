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

  def seed_bowlers
    load "#{Rails.root}/db/seeds/test/bowlers.seeds.rb"
  end

  def seed_squad_entries
    load "#{Rails.root}/db/seeds/test/squad_entries.seeds.rb"
  end

  def standard_setup
  	puts "Performaing stadrd setup..."

  	seed_sletba_open
  	seed_squad_entries

  	@squad_entry1 = SquadEntry.find(1)
  	@squad_entry2 = SquadEntry.find(2)
  end

  def create_squad_entry_for_bowler_juan

    @new_squad_entry_for_bowler_juan = SquadEntry.new(game_type: game_types(:singles))
    @new_squad_entry_for_bowler_juan.bowlers << bowlers(:juan)
    @new_squad_entry_for_bowler_juan.save!
    return @new_squad_entry_for_bowler_juan
  end

end
