class Note < ApplicationRecord
  belongs_to :project
  validates :title, :text, presence: true

end
