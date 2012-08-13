class Appointment < ActiveRecord::Base
  attr_accessible :description, :endtime, :starttime, :title, :location

  validates :title, :location, :starttime, :endtime, presence: true

  after_create :appointment_created

  protected
  def appointment_created
    SmsHub.appointment_created self
  end
end
