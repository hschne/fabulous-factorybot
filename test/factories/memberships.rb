FactoryBot.define do
  factory :membership do
    user
    project
    role { 'admin' }
  end
end
