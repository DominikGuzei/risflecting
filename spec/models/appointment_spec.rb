require 'spec_helper'

describe Appointment do
  it { should validate_presence_of :title }
  it { should validate_presence_of :location }
  it { should validate_presence_of :starttime }
  it { should validate_presence_of :endtime }

  it 'should not allow an starttime after the endtime' do
    appointment = FactoryGirl.build :appointment

    appointment.valid?.should be true

    appointment.starttime = 2.days.from_now
    appointment.endtime = 1.day.from_now

    appointment.valid?.should be false
  end

  describe 'after_create callback' do
    it 'should call the SmsHub method and pass an instance of itself' do
      appointment = FactoryGirl.build :appointment

      SmsHub.should_receive(:appointment_created).with appointment

      appointment.save
    end
  end
end
