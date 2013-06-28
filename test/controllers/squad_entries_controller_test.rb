require 'test_helper'

class SquadEntriesControllerTest < ActionController::TestCase
  setup do
    @squad_entry = squad_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:squad_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create squad_entry" do
    assert_difference('SquadEntry.count') do
      post :create, squad_entry: { bowlers_id: @squad_entry.bowlers_id, category: @squad_entry.category, entry_type: @squad_entry.entry_type, squad_id: @squad_entry.squad_id }
    end

    assert_redirected_to squad_entry_path(assigns(:squad_entry))
  end

  test "should show squad_entry" do
    get :show, id: @squad_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @squad_entry
    assert_response :success
  end

  test "should update squad_entry" do
    patch :update, id: @squad_entry, squad_entry: { bowlers_id: @squad_entry.bowlers_id, category: @squad_entry.category, entry_type: @squad_entry.entry_type, squad_id: @squad_entry.squad_id }
    assert_redirected_to squad_entry_path(assigns(:squad_entry))
  end

  test "should destroy squad_entry" do
    assert_difference('SquadEntry.count', -1) do
      delete :destroy, id: @squad_entry
    end

    assert_redirected_to squad_entries_path
  end
end
