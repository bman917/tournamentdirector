require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get show_entries" do
    get :show_entries
    assert_response :success
  end

end
