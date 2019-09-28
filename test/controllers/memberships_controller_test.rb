require 'test_helper'

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @password = 'password'
    @user = create(:user, password: @password)
    login
  end

  test 'index should return success' do
    project = create(:project_for_user, user: @user)

    get project_memberships_path(project_id: project.id)

    assert_response :success
  end

  test 'new should return success' do
    project = create(:project_for_user, user: @user)

    get new_project_membership_path(project_id: project.id)
    assert_response :success
  end

  test 'create should return redirect' do
    project = create(:project_for_user, user: @user)
    second_user = create(:user)

    post project_memberships_path(project_id: project.id, params:
      { membership: { user_id: second_user.id, role: 'admin' } })
    assert_response :redirect
  end

  test 'destroy should return success' do
    project = create(:project_for_user, user: @user)
    membership = create(:membership, project: project)

    delete membership_path(membership)
    assert_response :redirect
  end

  private

  def login(user: @user, password: @password)
    post login_path(params: { email: user.email, password: password })
  end


end
