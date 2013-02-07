ActionMailer::Base.smtp_settings = {
  :address              => "smtp.postmarkapp.com",
  :port                 => 25,
  :user_name            => ENV["POSTMARK_API_KEY"],
  :password             => ENV["POSTMARK_API_KEY"],
  :authentication       => "plain",
  :enable_starttls_auto => true
}
