class JobsController < ApplicationController

  def index
    @jobs = Job.find_by(event_id: params[:event_id])
  end

  def show
  end

end
