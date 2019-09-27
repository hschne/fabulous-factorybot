FactoryBot.define do
  factory :project do
    name { 'name' }
  end

  factory :project_for_user, parent: :project do
    transient do
      user { create(:user) }
      role { 'admin' }
    end

    after(:create) do |project, evaluator|
      membership = create(:membership,
                          project: project,
                          user: evaluator.user,
                          role: evaluator.role)
      project.update(memberships: [membership])
    end
  end
end
