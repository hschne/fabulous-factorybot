FactoryBot.define do
  factory :project do
    name { "Name" }
    description { "Description" }
  end

  factory :user_project, parent: :project do 
    transient do 
      user { create(:user, id: 1) }
    end

    after(:create) do |project, evaluator|
      membership = create(:membership, project: project, user: evaluator.user)
      project.update(memberships: [membership])
    end
  end
end
