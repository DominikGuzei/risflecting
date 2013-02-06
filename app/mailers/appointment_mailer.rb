class AppointmentMailer < ActionMailer::Base
  default from: "Risflecting Intern <#{ENV['APPLICATION_EMAIL_ADDRESS']}>"

  def last_minute_acceptance_information recipient, user, appointment
    @user = user
    @appointment = appointment

    mail :to => recipient.email, :subject => "#{user.full_name} hat zum Termin '#{appointment.title}' zugesagt"
  end
end
