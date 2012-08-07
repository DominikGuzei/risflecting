class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :forename, :surname, :phone
  # attr_accessible :title, :body

  validates :forename, :surname, :phone, :presence => true

   def passwords_match?
    password == password_confirmation && !password.blank?
  end
end
