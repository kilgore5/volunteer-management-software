class ApplicationResponseMailer < ApplicationMailer


  def application_accepted_email(user, application, event)
    @user = user
    @application = application
    @event = event
    @url  = edit_user_url(@user)
    subject = 'Your ' + @event.name + ' volunteer application has been accepted!'
    mail(to: @user.email, subject: subject)
  end

  def accepted_invitation_confirmation_email(user, application, event)
    @user = user
    @application = application
    @event = event
    # @url  = edit_user_url(@user)
    subject = 'Your ' + @event.name + ' volunteer position is secure!'
    mail(to: @user.email, subject: subject)
  end
end
