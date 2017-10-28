class ShiftMailer < ApplicationMailer

  def assigned(user_id, event_id)
    @user = User.find(user_id)
    @shifts = @user.shifts
    @event = Event.find(event_id)
    @url  = edit_user_url(@user)
    subject = "Important: #{@event.name} volunteer shifts"
    mail(to: @user.email, subject: subject)
  end

  def completed(user, shifts, event)
    @user = user
    @shifts = shifts
    @event = event
    @url  = edit_user_url(@user)
    subject = "Completed volunteer shift @#{@event.name}!"
    mail(to: @user.email, subject: subject)
  end

  def missed(user, shifts, event)
    @user = user
    @shifts = shifts
    @event = event
    @url  = edit_user_url(@user)
    subject = "Missed volunteer shift @#{@event.name}"
    mail(to: @user.email, subject: subject)
  end

  def changed(user, shifts, event)
    @user = user
    @shifts = shifts
    @event = event
    @url  = edit_user_url(@user)
    subject = "Important: Update for #{@event.name} volunteer shifts"
    mail(to: @user.email, subject: subject)
  end
end
