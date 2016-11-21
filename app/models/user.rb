class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :notes
  validates_presence_of :last_name
  before_save :assign_role

  def assign_role
    self.role = Role.find_by name: "User" if self.role.nil?
  end

  def admin?
    self.role.name == "Admin"
  end

  def head?
    self.role.name == "Head"
  end

end
