require 'test_helper'

class ProjectPolicyTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  test 'show for user with any membership returns true' do
    note = create(:project_for_user, user: @user)

    policy = ProjectPolicy.new(@user, note)

    assert(policy.show?)
  end

  test 'update for user with admin returns true' do
    note = create(:project_for_user, user: @user, role: 'admin')

    policy = ProjectPolicy.new(@user, note)

    assert(policy.update?)
  end

  test 'update for user with writer returns false' do
    project = create(:project_for_user, user: @user, role: 'writer')

    policy = ProjectPolicy.new(@user, project)

    assert_not(policy.update?)
  end

  test 'scope returns notes where membership for users exists' do
    user_project = create(:project_for_user, user: @user)
    another_project = create(:project_for_user)

    scope = ProjectPolicy::Scope.new(@user, Project)
    results = scope.resolve

    assert_includes(results, user_project)
    refute_includes(results, another_project)
  end
end
