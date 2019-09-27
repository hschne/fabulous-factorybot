require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login should get new" do
    get login_path
    assert_response :success
  end

  test "create should create session and login" do
    post sessions_path
    assert_response :success
  end

  test "login should redirect and logut" do
    get logout_path

    assert_response :success
  end

end
