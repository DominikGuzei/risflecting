class Appointment < ActiveRecord::Base
  attr_accessible :description, :endtime, :starttime, :title, :location

  validates :title, :location, :starttime, :endtime, presence: true
end
