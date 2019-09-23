FactoryBot.define do
  factory :membership do
    user
    project
    role { 'Writer' }
  end
end
