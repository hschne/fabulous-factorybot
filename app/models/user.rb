class User < ApplicationRecord
  has_secure_password

  belongs_to :plan

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
