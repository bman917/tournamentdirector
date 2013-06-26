require 'test_helper'

class BowlingAssociationsControllerTest < ActionController::TestCase
  setup do
    @bowling_association = bowling_associations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bowling_associations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bowling_association" do
    assert_difference('BowlingAssociation.count') do
      post :create, bowling_association: { name: @bowling_association.name }
    end

    assert_redirected_to bowling_association_path(assigns(:bowling_association))
  end

  test "should show bowling_association" do
    get :show, id: @bowling_association
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bowling_association
    assert_response :success
  end

  test "should update bowling_association" do
    patch :update, id: @bowling_association, bowling_association: { name: @bowling_association.name }
    assert_redirected_to bowling_association_path(assigns(:bowling_association))
  end

  test "should destroy bowling_association" do
    assert_difference('BowlingAssociation.count', -1) do
      delete :destroy, id: @bowling_association
    end

    assert_redirected_to bowling_associations_path
  end
end
