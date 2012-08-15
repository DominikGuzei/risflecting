class Appointment < ActiveRecord::Base
  has_many :appointment_responses
  has_many :accepting_users, :through => :appointment_responses,
    :source => :user,
    :conditions => { :appointment_responses => { :accepted => true } }
  has_many :rejecting_users, :through => :appointment_responses,
    :source => :user,
    :conditions => { :appointment_responses => { :accepted => false } }

  attr_accessible :description, :endtime, :starttime, :title, :location

  validates :title, :location, :starttime, :endtime, presence: true
  validate :starttime_is_before_endtime

  after_create :created

  protected
  def created
    SmsHub.appointment_created self
  end

  def starttime_is_before_endtime
    errors.add :starttime, 'muss vor dem Ende liegen' if starttime && endtime && starttime > endtime
  end
end
