class PagesController < ApplicationController
  def home
    @events = Event.all.includes(:client_owner)
  end
end
