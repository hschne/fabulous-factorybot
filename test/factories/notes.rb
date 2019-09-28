require 'faker'

FactoryBot.define do
  factory :note do
    title { 'title' }
    text { 'text' }
    project
  end

  factory :random_note, parent: :note do
    title { Faker::Name.name }
    text { Faker::Lorem.paragraph }
  end

  factory :note_for_user, parent: :note do
    transient do
      user { create(:user) }
      role { 'admin' }
    end
    project { association :project_for_user, user: user, role: role }
  end
end
