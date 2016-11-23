class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :notes
  validates_presence_of :last_name
  before_save :assign_role
  validates :first_name, presence: true, length: { in: 1..255 }
  validates :last_name, length: { in: 1..255 }

  def assign_role
    self.role = Role.find_by name: "User" if self.role.nil?
  end

  ROLES = %i(admin).freeze

  def roles=(roles)
    roles = [*roles].map(&:to_sym)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def has_role?(role)
    roles.include?(role)
  end

end
