class User < ActiveRecord::Base
  belongs_to :role
  has_many :documents
  has_many :questions
  has_many :projects
  has_many :comments
  has_many :appointment_responses
  has_many :accepted_appointments, :through => :appointment_responses,
    :source => :appointment,
    :conditions => { :appointment_responses => { :accepted => true } }
  has_many :rejected_appointments, :through => :appointment_responses,
    :source => :appointment,
    :conditions => { :appointment_responses => { :accepted => false } }

  devise :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader

  attr_accessible :email, :password, :password_confirmation, :remember_me, :forename, :surname, :phone, :description, :avatar, :avatar_cache, :role_id

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

  def has_role? role_name
    role.name == role_name.to_s.camelize
  end

  def full_name
    [forename, surname].join(' ')
  end

  def formal_name
    [surname, forename].join(' ')
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
    else
      appointment_responses.create :appointment_id => appointment_id, :accepted => accepted
    end
  end
end
