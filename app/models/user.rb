class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :forename, :surname, :phone

  validates :forename, :surname, :phone, :presence => true

  def passwords_match?
    password == password_confirmation && !password.blank?
  end
end
