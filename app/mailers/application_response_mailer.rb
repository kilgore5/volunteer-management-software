class ApplicationResponseMailer < ApplicationMailer


  # Admins to User
  def accepted(user, application, event)
    @user = user
    @application = application
    @event = event
    @url  = edit_user_url(@user)
    subject = "Your #{@event.name} volunteer application has been accepted!"
    mail(to: @user.email, subject: subject)
  end

  def waitlisted(user, application, event)
    @user = user
    @application = application
    @event = event
    subject = "Regarding your #{@event.name} volunteer application"
    mail(to: @user.email, subject: subject)
  end

  def denied(user, application, event)
    @user = user
    @application = application
    @event = event
    subject = "Regarding your #{@event.name} volunteer application"
    mail(to: @user.email, subject: subject)
  end

  # User Triggered
  def confirmed(user, application, event)
    @user = user
    @application = application
    @event = event
    subject = "Your #{@event.name} volunteer position is secure!"
    mail(to: @user.email, subject: subject)
  end

  
end
