require 'spec_helper'

describe AppointmentResponse do
  before :each do
    @appointment_response = FactoryGirl.create :appointment_response
  end

  after :each do
    @appointment_response.destroy
  end

  it { should ensure_inclusion_of(:accepted).in_array [true, false] }
  it { should validate_uniqueness_of(:appointment_id).scoped_to :user_id }

  it { should allow_mass_assignment_of :appointment_id }
  it { should allow_mass_assignment_of :user_id }
  it { should allow_mass_assignment_of :accepted }

  it { should belong_to :user }
  it { should belong_to :appointment }

  describe '#saved' do
    it 'should call the deliver_last_minute_acceptance_informations method if the acceptance happened in the last 7 days before the appointment' do
      appointment_response = FactoryGirl.build :appointment_response, :accepted => true

      appointment_response.should_receive(:deliver_last_minute_acceptance_information).once

      appointment_response.appointment.starttime = 8.days.from_now
      appointment_response.save

      appointment_response.appointment.starttime = 6.days.from_now
      appointment_response.save
    end
  end

  describe '#is_last_minute_acceptance?' do
    it 'should only return true for acceptances' do
      accepted_appointment_response = FactoryGirl.create :appointment_response, :accepted => true
      accepted_appointment_response.appointment.starttime = 4.days.from_now

      rejected_appointment_response = FactoryGirl.create :appointment_response, :accepted => false
      rejected_appointment_response.appointment.starttime = 4.days.from_now

      accepted_appointment_response.is_last_minute_acceptance?.should be true
      rejected_appointment_response.is_last_minute_acceptance?.should be false
    end

    it 'should only return true for acceptances in the last 7 days before the appointment' do
      appointment_response = FactoryGirl.create :appointment_response, :accepted => true

      appointment_response.appointment.starttime = 8.days.from_now
      appointment_response.is_last_minute_acceptance?.should be false

      appointment_response.appointment.starttime = 7.days.from_now
      appointment_response.is_last_minute_acceptance?.should be true

      appointment_response.appointment.starttime = 6.days.from_now
      appointment_response.is_last_minute_acceptance?.should be true
    end
  end

  describe '#deliver_last_minute_acceptance_information' do
    before :each do
      @user = FactoryGirl.create :user
      @appointment = FactoryGirl.create :appointment, :starttime => 6.days.from_now
      @appointment_response = FactoryGirl.build :appointment_response, :accepted => true, :user_id => @user.id, :appointment_id => @appointment.id
    end

    it 'should deliver the mail with the correct data' do
      admin = FactoryGirl.create :admin

      AppointmentResponseMailer.should_receive(:last_minute_acceptance_information).with(admin, @user, @appointment).and_return(double('mailer', :deliver => true))

      @appointment_response.save
    end

    it 'should deliver the email to each admin' do
      number_of_admins = 5
      FactoryGirl.create_list :admin, number_of_admins

      AppointmentResponseMailer.should_receive(:last_minute_acceptance_information).exactly(number_of_admins).times.and_return(double('mailer', :deliver => true))

      @appointment_response.save
    end
  end
end
