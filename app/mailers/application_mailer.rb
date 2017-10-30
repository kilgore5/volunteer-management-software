class ApplicationMailer < ActionMailer::Base
  default from: ENV['mailer_email']
  append_view_path Rails.root.join('app', 'views', 'mailers')
  layout 'mailer'
end
