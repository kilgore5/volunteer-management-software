class ShiftsController < ApplicationController
  def index
    @shifts = Shift
      .includes(:volunteer, :rotation, :job)
      .paginate(page: params[:page], per_page: 50)
    @event = @current_event
  end

  def notify_all
    @shifts = Shift.joins(:volunteer).where(state: 'created')
    respond_to do |format|
      if @shifts.each { |a| a.assign_vol! }
        format.html { redirect_to request.referrer, notice: 'The volunteers have been notified!' }
      else
        format.html { redirect_to request.referrer, flash: { "alert-warning": "Oops, something went wrong; please try again." } }
      end
    end
  end
end
