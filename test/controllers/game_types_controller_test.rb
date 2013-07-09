require 'test_helper'

class GameTypesControllerTest < ActionController::TestCase
  setup do
    @game_type = game_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_type" do
    assert_difference('GameType.count') do
      post :create, game_type: { name: @game_type.name, number_of_games: @game_type.number_of_games, number_of_players: @game_type.number_of_players }
    end

    assert_redirected_to game_type_path(assigns(:game_type))
  end

  test "should show game_type" do
    get :show, id: @game_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game_type
    assert_response :success
  end

  test "should update game_type" do
    patch :update, id: @game_type, game_type: { name: @game_type.name, number_of_games: @game_type.number_of_games, number_of_players: @game_type.number_of_players }
    assert_redirected_to game_type_path(assigns(:game_type))
  end

  test "should destroy game_type" do
    assert_difference('GameType.count', -1) do
      delete :destroy, id: @game_type
    end

    assert_redirected_to game_types_path
  end
end
