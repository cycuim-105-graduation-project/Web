# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: Settings.sendgrid.username,
  password:  Settings.sendgrid.password,
  domain:    Settings.domain,
  address:   Settings.sendgrid.address,
  port:      587,
  authentication: :plain,
  enable_starttls_auto: true
}
