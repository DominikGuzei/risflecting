require 'twilio-ruby'

module SmsHub
  def self.appointment_created appointment
    User.all.each do |user|
      self.send :from => ENV['TWILIO_PHONE_NUMBER'],
                :to   => user.phone,
                :body => "Ein neuer Risflecting Termin wurde erstellt: #{appointment.title}"
    end
  end

  def self.appointment_response_saved appointment_response
    Role.find_by_name('Admin').users.each do |user|
      self.send :from => ENV['TWILIO_PHONE_NUMBER'],
                :to   => user.phone,
                :body => self.generate_appointment_response_saved_message(appointment_response)
    end
  end

  def self.generate_appointment_response_saved_message appointment_response
    user = appointment_response.user

    if appointment_response.accepted
      "#{user.surname} #{user.forename} hat dem Termin '#{appointment_response.appointment.title}' zugesagt."
    else
      "#{user.surname} #{user.forename} hat dem Termin '#{appointment_response.appointment.title}' abgesagt."
    end
  end

  def self.send sms
    if self.should_send_sms? sms
      client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      client.account.sms.messages.create sms
    end
  end

  def self.should_send_sms? sms
    if Rails.env == 'test'
      return false
    elsif Rails.env == 'production'
      return true
    elsif Rails.env == 'development'
      return ENV['DEVELOPER_PHONE_NUMBERS'].split(' ').include? sms[:to]
    end
  end
end
