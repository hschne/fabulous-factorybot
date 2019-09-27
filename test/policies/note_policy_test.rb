require 'test_helper'

class NotePolicyTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  test 'show for user with any membership returns true' do
    note = create(:note_for_user, user: @user)

    policy = NotePolicy.new(@user, note)

    assert(policy.show?)
  end

  test 'update for user with admin returns true' do
    note = create(:note_for_user, user: @user, role: 'admin')

    policy = NotePolicy.new(@user, note)

    assert(policy.update?)
  end

  test 'update for user with writer returns true' do
    note = create(:note_for_user, user: @user, role: 'writer')

    policy = NotePolicy.new(@user, note)

    assert(policy.update?)
  end

  test 'update for user with reader returns false' do
    note = create(:note_for_user, user: @user, role: 'reader')

    policy = NotePolicy.new(@user, note)

    assert_not(policy.update?)
  end

  test 'scope returns notes where membership for users exists' do
    user_note = create(:note_for_user, user: @user)
    another_note = create(:note_for_user)

    scope = NotePolicy::Scope.new(@user, Note)
    results = scope.resolve

    assert_includes(results, user_note)
    refute_includes(results, another_note)
  end
end
