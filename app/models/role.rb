# frozen_string_literal: true
class Role < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, presence: true, length: { in: 1..255 }
  validates :description, length: { maximum: 1023 }
end
