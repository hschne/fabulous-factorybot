require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test 'project name must be present' do
    project = build(:project, name: nil)

    assert(project.invalid?)
  end
end
