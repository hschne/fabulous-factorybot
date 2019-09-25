class Plan < ApplicationRecord

  enum type: {
    basic: 'basic',
    pro: 'pro'
  }
  validates :name, uniqueness: true, inclusion: { in: types }
end
