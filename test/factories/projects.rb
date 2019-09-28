require 'faker'

FactoryBot.define do
  factory :project do
    name { 'name' }
  end

  factory :random_project, parent: :project do
    transient do
      note_count { 10 }
    end
    name { Faker::Name.name }

    after(:build) do |project, evaluator|
      project.notes = build_list(:random_note, evaluator.note_count, project: project)
    end
  end


  factory :project_for_user, parent: :project do
    transient do
      user { create(:user) }
      role { 'admin' }
    end

    after(:build) do |project, evaluator|
      project.memberships << build(:membership,
                                   project: project,
                                   user: evaluator.user,
                                   role: evaluator.role)
    end
  end
end
