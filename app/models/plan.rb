class Plan < ApplicationRecord
  enum name: {
    basic: 'basic',
    pro: 'pro'
  }
  validates :name, uniqueness: true, inclusion: { in: names }
end
