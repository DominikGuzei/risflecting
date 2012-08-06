class Appointment < ActiveRecord::Base
  attr_accessible :description, :endtime, :starttime, :title

  validates :title, :starttime, :endtime, presence: true
end
