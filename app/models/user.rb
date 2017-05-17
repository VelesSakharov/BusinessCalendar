# frozen_string_literal: true
class User < ApplicationRecord
  ROLES = %i(admin head user banned).freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable
  has_and_belongs_to_many :roles
  has_many :notes
  validates_presence_of :last_name
  validates :first_name, presence: true, length: { in: 1..255 }
  validates :last_name, length: { in: 1..255 }
  #

  def has_role?(role)
    roles.find_by_name(role) ? true : false
  end
end
