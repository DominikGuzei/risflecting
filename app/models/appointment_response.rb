class AppointmentResponse < ActiveRecord::Base
  belongs_to :user
  belongs_to :appointment

  attr_accessible :appointment_id, :user_id, :accepted

  validates :appointment_id, :uniqueness => { :scope => :user_id }
  validates :accepted, :inclusion => { :in => [true, false] }

  after_save :saved

  def last_minute_acceptance?
    if accepted && appointment.starttime <= 7.days.from_now
      return true
    else
      return false
    end
  end

  protected
  def saved
    deliver_last_minute_acceptance_information if last_minute_acceptance?
  end

  def deliver_last_minute_acceptance_information
    Role.find_by_name('Admin').users.each do |admin|
      AppointmentResponseMailer.last_minute_acceptance_information(admin, user, appointment).deliver
    end
  end
end
