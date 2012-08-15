class AppointmentResponse < ActiveRecord::Base
  belongs_to :user
  belongs_to :appointment

  attr_accessible :appointment_id, :user_id, :accepted

  validates :appointment_id, :uniqueness => { :scope => :user_id }
  validates :accepted, :inclusion => { :in => [true, false] }

  after_save :saved

  protected
  def saved
    SmsHub.appointment_response_saved self
  end
end
