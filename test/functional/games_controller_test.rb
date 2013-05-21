require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get answer" do
    get :answer
    assert_response :success
  end

  test "should get finish" do
    get :finish
    assert_response :success
  end

end
