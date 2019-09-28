require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login should return success" do
    get login_path
    assert_response :success
  end

  test "login with valid password should login" do
    user = create(:user)
    post login_path(params: { email: user.email, password: 'password' })
    assert_response :redirect
    assert('Logged in!', flash[:notice])
  end

  test "login with invalid password should render new and alert" do
    user = create(:user)
    post login_path(params: { email: user.email, password: 'xzx' })
    assert_response :ok
    assert(flash[:alert])
  end

  test "login should redirect and logut" do
    get logout_path

    assert_response :redirect
    assert(flash[:notice])
  end
end
