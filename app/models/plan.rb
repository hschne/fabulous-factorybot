class Plan < ApplicationRecord
  validates :name, uniqueness: true, inclusion: { in: %w[Basic Business Pro] }
end
