require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @password = 'password'
    @user = create(:user, password: @password)
  end


  test "should get new" do
    login
    project = create(:project_for_user, user: @user)

    get new_project_note_path(project_id: project.id)
    assert_response :success
  end

  def login(user: @user, password: @password)
    post login_path(params: { email: user.email, password: password })
  end

end
