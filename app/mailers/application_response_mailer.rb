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

  def confirm_reminder(user, application, event)
    @user = user
    @application = application
    @event = event
    @url  = edit_user_url(@user)
    subject = "Reminder to confirm your volunteer spot at #{@event.name}"
    mail(to: @user.email, subject: subject)
  end

  # Admins to User
  def second_chance(user, application, event)
    @user = user
    @application = application
    @event = event
    @url  = edit_user_url(@user)
    subject = "Your #{@event.name} volunteer application has been accepted!"
    mail(to: @user.email, subject: subject)
  end

  # Example to send the reminder
  # Need to set all apps who don't have a state to state: "submitted"
  # apps = Apply.where state: "accepted"
  # apps.each { |app| ApplicationResponseMailer.confirm_reminder(app.user, app, app.event).deliver_later }



  # User Triggered
  def confirmed(user, application, event)
    @user = user
    @application = application
    @event = event
    subject = "Your #{@event.name} volunteer position is secure!"
    mail(to: @user.email, subject: subject)
  end

  
end
