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

  def self.past
    Appointment.where('endtime < NOW()').order(:starttime).reverse
  end

  def self.future
    Appointment.where('endtime > NOW()').order(:starttime)
  end

  def future?
    endtime > Time.now
  end

  protected
  def created
    User.all.each do |user|
      AppointmentMailer.new_appointment_information(user, self).deliver unless user.confirmed_at == nil
    end
  end

  def starttime_is_before_endtime
    errors.add :starttime, 'muss vor dem Ende liegen' if starttime && endtime && starttime > endtime
  end
end
