class EventDaysController < ApplicationController
  before_action :set_event_day, only: [:show, :update]
  
  def show
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_day
      @event_day = EventDay.includes(event: :jobs).includes(:rotations).friendly.find(params[:id])
      @event = @event_day.event
      # @rotations = @event_day.rotations.where()
    end  

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_day_params
      params.require(:event_day).permit(:date, :event_id, {:job_ids => []})
    end    
end
