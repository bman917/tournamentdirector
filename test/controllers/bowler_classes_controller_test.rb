require 'test_helper'

class BowlerClassesControllerTest < ActionController::TestCase
  setup do
    @bowler_class = bowler_classes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bowler_classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bowler_class" do
    assert_difference('BowlerClass.count') do
      post :create, bowler_class: {  }
    end

    assert_redirected_to bowler_class_path(assigns(:bowler_class))
  end

  test "should show bowler_class" do
    get :show, id: @bowler_class
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bowler_class
    assert_response :success
  end

  test "should update bowler_class" do
    patch :update, id: @bowler_class, bowler_class: {  }
    assert_redirected_to bowler_class_path(assigns(:bowler_class))
  end

  test "should destroy bowler_class" do
    assert_difference('BowlerClass.count', -1) do
      delete :destroy, id: @bowler_class
    end

    assert_redirected_to bowler_classes_path
  end
end
