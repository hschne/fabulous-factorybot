class User < ApplicationRecord
  belongs_to :plan
  has_many :memberships

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
