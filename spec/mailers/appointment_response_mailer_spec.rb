require "spec_helper"

describe AppointmentResponseMailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  describe '#last_minute_acceptance_information' do
    before :each do
      @admin = FactoryGirl.create :admin
      @user = FactoryGirl.create :user
      @appointment = FactoryGirl.create :appointment
      @mail = AppointmentResponseMailer.last_minute_acceptance_information @admin, @user, @appointment
    end

    it 'should be sent to the admin' do
      @mail.should be_delivered_to @admin.email
    end

    it 'should contain user and appointment information in the subject' do
      @mail.should have_subject /#{@user.surname} #{@user.forename}/
      @mail.should have_subject /#{@appointment.title}/
    end

    it 'should contain user and appointment information in the body' do
      @mail.should have_body_text /#{@user.surname} #{@user.forename}/
      @mail.should have_body_text /#{@appointment.title}/
    end
  end
end
