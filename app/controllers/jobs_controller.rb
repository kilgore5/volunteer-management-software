class JobsController < ApplicationController

  before_action :set_job, only: [:update]  

  def index
    @jobs = Job.where(event_id: params[:event_id]).includes(:event, :skill_requirements)
    @event = Event.find(params[:event_id])
  end

  def show
  end

  # # POST /jobs
  # # POST /jobs.json
  # def create
  #   @job = Event.new(job_params)

  #   respond_to do |format|
  #     if @job.save
  #       format.html { redirect_to @job, notice: 'Job was successfully created.' }
  #       format.json { render :show, status: :created, location: @job }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @job.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to event_jobs_path(@event), notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /jobs/1
  # # DELETE /jobs/1.json
  # def destroy
  #   @job.destroy
  #   respond_to do |format|
  #     format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.includes(:event).find(params[:id])
      @event = @job.event
    end    

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:id, :title, :description, :event_id, :shifts_required_per_day, :workers_per_shift, :hours_per_shift, skill_requirements_attributes: [:id, :title, :description, :_destroy])
    end  

end
