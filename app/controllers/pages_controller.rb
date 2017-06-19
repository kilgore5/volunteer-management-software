class PagesController < ApplicationController

  layout "landing"

  # before_action :redirect_to_account, only: [:home]
  
  def home
    @applied = user_has_applied
    if @applied
      redirect_to edit_user_path(current_user)
    end    
    @events = Event.includes(:client_owner, :event_days, :jobs).order('start_time ASC')
  end

  def user_has_applied
    if user_signed_in?
      if @current_event.applications.find_by(user_id: current_user.id).nil?
        return false
      end
    else
      return false
    end
    return true
  end

end
