class PagesController < ApplicationController

  layout "landing", only: [:home]

  # before_action :redirect_to_account, only: [:home]
  
  def home
    @applied = user_has_applied
    if @applied
      redirect_to edit_user_path(current_user)
    end    
    @events = Event.includes(:client_owner, :event_days, :jobs).order('start_time ASC')
  end

  def terms
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

  def letsencrypt
    # https://collectiveidea.com/blog/archives/2016/01/12/lets-encrypt-with-a-rails-app-on-heroku
    render plain: "uItkXMzclAiV7_4ojbxddd7JYFnhQYXlvaijALcGsME.8IQxXUZIlzqf2nS9C1pFPj5dLH9qDjwxQBeb310KXwM"
  end

end
