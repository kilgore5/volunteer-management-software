class EventDaysController < ApplicationController
  before_action :set_event_day, only: [:show, :update]
  before_action :set_event, only: [:index, :show]
  
  def show
  end

  def index
    @event_days = @event.event_days
  end

  def update
    respond_to do |format|
      if @event_day.update(event_day_params)
        format.html { redirect_to @event_day.event, notice: 'Event day was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_day }
      else
        format.html { render :edit }
        format.json { render json: @event_day.errors, status: :unprocessable_entity }
      end
    end
  end

  def notify_multiple
    @shifts = Shift.where(id: params[:shift_ids]).where(state: 'created')
    respond_to do |format|
      if @shifts.each { |a| a.assign_vol! }
        format.html { redirect_to request.referrer, notice: 'The volunteers have been notified!' }
      else
        format.html { redirect_to request.referrer, flash: { "alert-warning": "Oops, something went wrong; please try again." } }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_day
      @event_day = EventDay.includes(event: :jobs).includes(:rotations, :shifts).friendly.find(params[:id])
    end

    def set_event
      if !params[:event_id].nil?  
        @event = Event.friendly.find(params[:event_id])
      else
        @event = @event_day.event
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_day_params
      params.require(:event_day).permit(:date, :event_id, {:job_ids => []})
    end

end
