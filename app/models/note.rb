class Note < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { in: 1..255 }
  validates :content, length: { maximum: 1023 }
end
