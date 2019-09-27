require 'test_helper'

class MembershipPolicyTest < ActiveSupport::TestCase
  test 'create for user with basic plan returns true' do
    plan = create(:plan, name: 'basic')
    user = create(:user, plan: plan)
    membership = create(:membership, user: user)

    policy = MembershipPolicy.new(user, membership)

    assert_not(policy.new?)
  end

  test 'create for user with pro plan returns true' do
    plan = create(:plan, name: 'pro')
    user = create(:user, plan: plan)
    membership = create(:membership, user: user)

    policy = MembershipPolicy.new(user, membership)

    assert(policy.new?)
  end

  test 'destroy for project where user is admin with pro plan returns true' do
    plan = create(:plan, name: 'pro')
    user = create(:user, plan: plan)
    membership = create(:membership, user: user, role: 'admin')

    policy = MembershipPolicy.new(user, membership)

    assert(policy.destroy?)
  end

  test 'scope returns memberships where where person is project admin' do
    user = create(:user)
    admin_project = create(:project_for_user, user: user, role: 'admin')
    reader_project = create(:project_for_user, user: user, role: 'reader')
    admin_membership = create(:membership, project: admin_project)
    reader_membership = create(:membership, project: reader_project)

    scope = MembershipPolicy::Scope.new(user, Membership)
    results = scope.resolve

    assert_includes(results, admin_membership)
    refute_includes(results, reader_membership)
  end
end
