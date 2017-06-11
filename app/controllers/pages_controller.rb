class PagesController < ApplicationController

  layout "landing"
  
  def home
    @events = Event.includes(:client_owner, :event_days, :jobs).order('start_time ASC')
  end

end
