require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user email must be present' do
    user = build(:user, email: nil)

    assert(user.invalid?)
  end

  test 'user name must be present' do
    user = build(:user, name: nil)

    assert(user.invalid?)
  end

  test 'user email with duplicate is invalid' do
    create(:user, email: 'custom@email.com')
    user = build(:user, email: 'custom@email.com')

    assert(user.invalid?)
  end

end
