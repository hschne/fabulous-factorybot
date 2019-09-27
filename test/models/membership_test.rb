require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  test 'validates membership role admin is valid' do
    membership = build(:membership, role: 'admin')

    assert(membership.valid?)
  end

  test 'validates membership role reader is valid' do
    membership = build(:membership, role: 'reader')

    assert(membership.valid?)
  end

  test 'validates membership role writer is valid' do
    membership = build(:membership, role: 'writer')

    assert(membership.valid?)
  end

  test 'validates unique role for user project' do
    first = create(:membership, role: 'writer')
    duplicate = build(:membership, role: 'writer', user: first.user, project: first.project)

    assert(duplicate.invalid?)
  end
end
