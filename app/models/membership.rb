class Membership < ApplicationRecord
  enum role: {
    admin: 'admin',
    reader: 'reader',
    writer: 'writer'
  }

  belongs_to :user
  belongs_to :project

  validates :role, inclusion: { in: roles }
end
