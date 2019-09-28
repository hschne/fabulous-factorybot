require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @password = 'password'
    @user = create(:user, password: @password)
    login
  end

  test 'index should return success' do
    get projects_path
    assert_response :success
  end

  test 'show should return success' do
    project = create(:project_for_user, user: @user)

    get project_path(project)

    assert_response :success
  end

  test 'new should return success' do
    get new_project_path

    assert_response :success
  end

  test 'edit should return success' do
    project = create(:project_for_user, user: @user)

    get edit_project_path(project)

    assert_response :success
  end

  test 'create should return redirect' do
    post projects_path(params: {
      project: { name: 'name', description: 'description' }
    })
    assert_response :redirect
  end

  test 'update should return redirect' do
    project = create(:project_for_user, user: @user)

    put project_path(project, params: {
      project: { name: 'name', description: 'description' }
    })
    assert_response :redirect
  end

  test 'destroy should return redirect' do
    project = create(:project_for_user, user: @user)

    delete project_path(project)

    assert_response :redirect
  end

  def login(user: @user, password: @password)
    post login_path(params: { email: user.email, password: password })
  end
end
