require 'test_helper'

class RankingUtilTest < ActiveSupport::TestCase

  def setup
  	standard_setup
  end

  test "Total Pinfalls of SquadEntry 1 and 2" do
  	assert_equal 404, @squad_entry1.total_pinfalls
 	assert_equal 408, @squad_entry2.total_pinfalls
  end



end

