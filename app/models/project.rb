class Project < ApplicationRecord
  has_many :notes, dependent: :destroy
  has_many :memberships, dependent: :destroy

  validates :name, presence: true
end
