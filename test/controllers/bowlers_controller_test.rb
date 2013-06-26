require 'test_helper'

class BowlersControllerTest < ActionController::TestCase
  setup do
    @bowler = bowlers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bowlers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bowler" do
    assert_difference('Bowler.count') do
      post :create, bowler: { bowling_association_id: @bowler.bowling_association_id, name: @bowler.name }
    end

    assert_redirected_to bowler_path(assigns(:bowler))
  end

  test "should show bowler" do
    get :show, id: @bowler
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bowler
    assert_response :success
  end

  test "should update bowler" do
    patch :update, id: @bowler, bowler: { bowling_association_id: @bowler.bowling_association_id, name: @bowler.name }
    assert_redirected_to bowler_path(assigns(:bowler))
  end

  test "should destroy bowler" do
    assert_difference('Bowler.count', -1) do
      delete :destroy, id: @bowler
    end

    assert_redirected_to bowlers_path
  end
end
