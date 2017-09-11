class ApplicationMailer < ActionMailer::Base
  default from: ENV['mailer_email']
  layout 'mailer'
end
