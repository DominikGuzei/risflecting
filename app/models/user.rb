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
  validate :phone_number_has_correct_format

  before_save :normalize_phone

  def normalize_phone
    unless phone.nil?
      self.phone = Phony.formatted(Phony.normalize(self.phone), :format => :international, :spaces => '')
    end
  end

  def phone_number_has_correct_format
    unless Phony.plausible? phone
      errors.add :phone, 'muss richtig formatiert sein (z.B. +436642312342)'
    end
  end

  def passwords_match?
    password == password_confirmation && !password.blank?
  end

  def has_role? role
    self.roles.exists?(:name => role.to_s.camelize)
  end

  def accept_appointment appointment_id
    create_or_update_appointment_response appointment_id, true
  end

  def reject_appointment appointment_id
    create_or_update_appointment_response appointment_id, false
  end

  private
  def create_or_update_appointment_response appointment_id, accepted
    if response = appointment_responses.find_by_appointment_id(appointment_id)
      response.update_attribute :accepted, accepted
      response.save
    else
      appointment_responses.create :appointment_id => appointment_id, :accepted => accepted
    end
  end
end
