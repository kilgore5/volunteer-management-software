class PagesController < ApplicationController

  layout "landing", only: [:home]

  # before_action :redirect_to_account, only: [:home]
  
  def home
    @admin = is_admin
    @applied = user_has_applied
    if @admin
      redirect_to @current_event
    elsif @applied
      redirect_to edit_user_path(current_user)
    end    
    @events = Event.includes(:client_owner, :event_days, :jobs).order('start_time ASC')
  end

  def terms
  end

  def is_admin
    (current_user && current_user.has_role?(:admin)) ? true : false
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
