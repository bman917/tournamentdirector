require 'test_helper'

class RankingUtilTest < ActiveSupport::TestCase

  def setup
  	standard_setup
  end

  test "Total Pinfalls of SquadEntry 1 and 2" do
  	assert_equal 404, @squad_entry1.total_pinfalls
  	assert_equal 408, @squad_entry2.total_pinfalls
 	assert_equal 452, @squad_entry3.total_pinfalls
 	assert_equal 456, @squad_entry4.total_pinfalls
 	assert_equal 300, @squad_entry5.total_pinfalls
 	assert_equal 304, @squad_entry6.total_pinfalls
  end

  test "Top Three Ranking" do
  	#ActiveRecord::Base.logger = Logger.new(STDOUT)
  	limit = 5

    squad_entries = RankingUtil.get_ranking(@sletba_open, @class_o, @singles, limit)

    first = squad_entries.first
    second = squad_entries.second
    third = squad_entries.third

    assert first.bowlers.exists?(bowlers(:pionie)), "Bowler Pionie should be first place"
    assert second.bowlers.exists?(bowlers(:juan)), "Bowler Juan should be second place instead of (#{second})"

  end



end
