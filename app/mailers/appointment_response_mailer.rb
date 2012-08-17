class AppointmentResponseMailer < ActionMailer::Base
  default from: 'risflecting@gmail.com'

  def last_minute_acceptance_information recipient, user, appointment
    @user = user
    @appointment = appointment

    mail :to => recipient.email, :subject => "#{user.surname} #{user.forename} hat zum Termin #{appointment.title} zugesagt"
  end
end
