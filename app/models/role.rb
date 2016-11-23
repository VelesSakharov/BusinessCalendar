class Role < ApplicationRecord
  has_many :users

  validates :name, presence: true, length: { in: 1..255 }
  validates :description, length: { in: 1..1023 }
end
