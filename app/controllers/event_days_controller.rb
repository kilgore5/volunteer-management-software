class EventDaysController < ApplicationController
  before_action :set_event_day, only: [:show]
  
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_day
      @event_day = EventDay.includes(event: :jobs).find(params[:id])
    end  
end
