class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :forename, :surname, :phone

  has_and_belongs_to_many :roles

  validates :forename, :surname, :phone, :presence => true

  def passwords_match?
    password == password_confirmation && !password.blank?
  end

  def has_role? role
    self.roles.exists?(:name => role.to_s.camelize)
  end
end
