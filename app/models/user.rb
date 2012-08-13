class User < ActiveRecord::Base
  has_many :appointment_responses
  has_many :accepted_appointments, :through => :appointment_responses,
    :source => :appointment,
    :conditions => { :appointment_responses => { :accepted => true } }
  has_many :rejected_appointments, :through => :appointment_responses,
    :source => :appointment,
    :conditions => { :appointment_responses => { :accepted => false } }

  devise :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :forename, :surname, :phone

  has_and_belongs_to_many :roles

  validates :forename, :surname, :phone, :presence => true

  def passwords_match?
    password == password_confirmation && !password.blank?
  end

  def has_role?(role)
    self.roles.exists?(:name => role.to_s.camelize)
  end

  def accept_appointment appointment_id
    appointment_responses.create :appointment_id => appointment_id, :accepted => true
  end

  def reject_appointment appointment_id
    appointment_responses.create :appointment_id => appointment_id, :accepted => false
  end
end
