require 'spec_helper'
require 'sms-spec'

describe SmsHub do
  include SmsSpec::Helpers

  describe '#appointment_created' do
    it 'calls send for every user' do
      number_of_users = 5
      FactoryGirl.create_list :user, number_of_users

      SmsHub.should_receive(:send).exactly(number_of_users).times

      SmsHub.appointment_created Appointment.new
    end
  end

  describe '#should_send_sms?' do
    before :each do
      number = '+4915115217077'
      ENV['DEVELOPER_PHONE_NUMBERS'] = number
      @sms = { :to => '+333869513692' }
      @whitelisted_sms = { :to => number }
    end

    it 'should always return true in production environment' do
      Rails.env = 'production'

      SmsHub.should_send_sms?(@sms).should be true
      SmsHub.should_send_sms?(@whitelisted_sms).should be true
    end

    it 'should only return true for developer phone numbers in development environment' do
      Rails.env = 'development'

      SmsHub.should_send_sms?(@sms).should be false
      SmsHub.should_send_sms?(@whitelisted_sms).should be true
    end

    it 'should always return false in test environment' do
      Rails.env = 'test'

      SmsHub.should_send_sms?(@sms).should be false
      SmsHub.should_send_sms?(@whitelisted_sms).should be false
    end
  end

  describe '#send' do
    before :each do
      clear_messages

      @sms = { :to => '123456789', :body => 'Test' }
    end

    it 'should use #should_send_sms? to check if SMS should be sent' do
      SmsHub.should_receive(:should_send_sms?).with(@sms).once

      SmsHub.send @sms
    end

    it 'should send an sms if #should_send_sms? returns true' do
      SmsHub.stub(:should_send_sms?).and_return(true)

      SmsHub.send @sms

      open_last_text_message_for @sms[:to]
      current_text_message.should have_body @sms[:body]
    end

    it 'should not send an sms if #should_send_sms? returns false' do
      SmsHub.stub(:should_send_sms?).and_return(false)

      SmsHub.send @sms

      messages_for(@sms[:to]).length.should equal 0
    end
  end
end
