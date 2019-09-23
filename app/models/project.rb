class Project < ApplicationRecord
  has_many :notes
  has_many :memberships

  validates :name, presence: true
end
