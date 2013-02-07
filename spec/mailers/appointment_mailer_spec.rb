require "spec_helper"

describe AppointmentMailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  describe '#last_minute_acceptance_information' do
    before :each do
      @admin = FactoryGirl.create :admin
      @user = FactoryGirl.create :user
      @appointment = FactoryGirl.create :appointment
      @mail = AppointmentMailer.last_minute_acceptance_information @admin, @user, @appointment
    end

    it 'should be sent to the admin' do
      @mail.should be_delivered_to @admin.email
    end

    it 'should contain user and appointment information in the subject' do
      @mail.should have_subject /#{@user.full_name}/
      @mail.should have_subject /#{@appointment.title}/
    end

    it 'should contain user and appointment information in the body' do
      @mail.should have_body_text /#{@user.full_name}/
      @mail.should have_body_text /#{@appointment.title}/
    end
  end

  describe '#new_appointment_information' do
    before :each do
      @appointment = FactoryGirl.create :appointment
      @user = FactoryGirl.create :user
      @mail = AppointmentMailer.new_appointment_information @user, @appointment
    end

    it 'should contain the appointment title in the subject' do
      @mail.should have_subject /#{@appointment.title}/
    end

    it 'should contain the appointment information and link in the body' do
      @mail.should have_body_text /#{@appointment.title}/
      @mail.should have_body_text /#{intern_appointment_url(@appointment)}/
    end
  end
end
