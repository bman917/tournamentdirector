require 'test_helper'

class GameTest < ActiveSupport::TestCase
   test "Do not allow game without a bowler" do
     assert_raise do 
     	game = Game.new(score: 100) 
     	game.save
     end
   end
end
