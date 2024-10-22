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
    it 'should call the AppointmentMailer with itself' do
      user = FactoryGirl.create :user
      appointment = FactoryGirl.build :appointment

      AppointmentMailer.should_receive(:new_appointment_information).with(user, appointment).and_return(double('mailer', :deliver => true))

      appointment.save
    end

    it 'should call the AppointmentMailer only for confirmed users' do
      FactoryGirl.create :user
      unconfirmed_user = FactoryGirl.create :user
      unconfirmed_user.confirmed_at = nil
      unconfirmed_user.save

      AppointmentMailer.should_receive(:new_appointment_information).exactly(1).times.and_return(double('mailer', :deliver => true))

      FactoryGirl.create :appointment
    end
  end

  describe '#past' do
    it 'should return all past appointments' do
      amount_of_past_appointments = 3
      FactoryGirl.create_list :appointment, amount_of_past_appointments, :starttime => 3.days.ago, :endtime => 2.days.ago
      FactoryGirl.create_list :appointment, 5

      past_appointments = Appointment.past

      past_appointments.length.should == amount_of_past_appointments
    end
  end

  describe '#future' do
    it 'should return all future appointments' do
      amount_of_future_appointments = 3
      FactoryGirl.create_list :appointment, 5, :starttime => 3.days.ago, :endtime => 2.days.ago
      FactoryGirl.create_list :appointment, amount_of_future_appointments

      future_appointments = Appointment.future

      future_appointments.length.should == amount_of_future_appointments
    end
  end

  describe '#future?' do
    it 'should return true if appointment is in the future' do
      appointment = FactoryGirl.create :appointment

      appointment.future?.should be_true
    end

    it 'should return false if appointment is in the past' do
      appointment = FactoryGirl.create :appointment, :starttime => 2.days.ago, :endtime => 1.day.ago

      appointment.future?.should be_false
    end
  end
end
