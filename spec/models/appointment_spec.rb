require 'spec_helper'

describe Appointment do
  it { should validate_presence_of :title }
  it { should validate_presence_of :location }
  it { should validate_presence_of :starttime }
  it { should validate_presence_of :endtime }

  describe 'after_create callback' do
    it 'should call the SmsHub method with itself' do
      appointment = FactoryGirl.build :appointment

      SmsHub.should_receive(:appointment_created).with(appointment)
      appointment.save
    end
  end
end
