class Appointment < ActiveRecord::Base
  attr_accessible :description, :endtime, :starttime, :title

  validates :title, presence: true
  validates :starttime, presence: true
  validates :endtime, presence: true
end
