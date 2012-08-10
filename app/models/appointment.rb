class Appointment < ActiveRecord::Base
  has_many :appointment_responses
  has_many :accepted_users, :through => :appointment_responses,
    :source => :user,
    :conditions => { :appointment_responses => { :accepted => true } }

  attr_accessible :description, :endtime, :starttime, :title, :location

  validates :title, :location, :starttime, :endtime, presence: true
end
