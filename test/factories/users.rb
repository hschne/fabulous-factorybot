FactoryBot.define do
  factory :user do
    name { 'User' }
    sequence(:email) { |i| "user#{i}@email.com" }
    plan
  end
end
