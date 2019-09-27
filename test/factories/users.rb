FactoryBot.define do
  factory :user do
    name { 'name' }
    password { 'password' }
    sequence(:email) { |i| "user#{i}@email.com" }
    plan
  end
end
