FactoryBot.define do
  factory :note do
    title { 'Title' }
    text { 'Text' }
    project 
  end

  factory :user_note, parent: :note do
    transient do
      person { create(:user) }
    end
    association :project, factory: :user_project
  end
end
