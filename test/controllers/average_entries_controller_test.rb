require 'test_helper'

class AverageEntriesControllerTest < ActionController::TestCase
  setup do
    @average_entry = average_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:average_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create average_entry" do
    assert_difference('AverageEntry.count') do
      post :create, average_entry: { average: @average_entry.average, bowler_id: @average_entry.bowler_id, record_date: @average_entry.record_date, user_id: @average_entry.user_id }
    end

    assert_redirected_to average_entry_path(assigns(:average_entry))
  end

  test "should show average_entry" do
    get :show, id: @average_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @average_entry
    assert_response :success
  end

  test "should update average_entry" do
    patch :update, id: @average_entry, average_entry: { average: @average_entry.average, bowler_id: @average_entry.bowler_id, record_date: @average_entry.record_date, user_id: @average_entry.user_id }
    assert_redirected_to average_entry_path(assigns(:average_entry))
  end

  test "should destroy average_entry" do
    assert_difference('AverageEntry.count', -1) do
      delete :destroy, id: @average_entry
    end

    assert_redirected_to average_entries_path
  end
end
