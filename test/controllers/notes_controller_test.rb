require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @password = 'password'
    @user = create(:user, password: @password)
    login
  end

  test 'index should return success' do
    project = create(:project_for_user, user: @user)

    get project_notes_path(project_id: project.id)
    assert_response :success
  end

  test 'show should return success' do
    note = create(:note_for_user, user: @user)

    get note_path(note)

    assert_response :success
  end

  test 'edit should return success' do
    note = create(:note_for_user, user: @user)

    get edit_note_path(note)

    assert_response :success
  end

  test 'new should return success' do
    project = create(:project_for_user, user: @user)

    get new_project_note_path(project_id: project.id)
    assert_response :success
  end

  test 'create should return redirect' do
    project = create(:project_for_user, user: @user)

    post project_notes_path(project_id: project.id, params: {
      note: { title: 'title', text: 'text' }
    })
    assert_response :redirect
  end

  test 'update should return redirect' do
    note = create(:note_for_user, user: @user)

    put note_path(note, params: {
      note: { title: 'new title', text: 'new text' }
    })
    assert_response :redirect
  end

  test 'destroy should return redirect' do
    note = create(:note_for_user, user: @user)

    delete note_path(note)
    assert_response :redirect
  end

  def login(user: @user, password: @password)
    post login_path(params: { email: user.email, password: password })
  end
end
