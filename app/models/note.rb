class Note < ApplicationRecord
  belongs_to :project
  validates :title, :text, presence: true
  has_many :memberships, through: :project

end
