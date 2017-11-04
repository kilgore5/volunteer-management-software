class RotationsController < ApplicationController
  before_action :set_rotation, only: [:show, :edit, :update, :destroy]

  # GET /rotations
  # GET /rotations.json
  # def index
  #   @rotations = Rotation.all
  # end

  def index
    if params[:job_id]
      @rotations = Rotation.where(:job_id => params[:job_id]).where(:day_id => params[:event_day_id]).includes(:job, :day).order('start_time')
      unless @rotations.empty?
        @job = @rotations.first.job
        @day = @rotations.first.day
      end

      @assigned_ids = assigned_vols
      flash[:notice] = "There are <b>#{@rotations.count}</b> rotations for this job".html_safe
      @vols = User.joins(:apps).where(applies: {job_id: @job.id}).where.not(id: @assigned_ids)
      # @vols = User.joins(:apps).where(applies: {job_id: @job.id})
    else
      @rotations = Rotation.all
    end
  end

  # GET /rotations/1
  # GET /rotations/1.json
  def show

  end

  # GET /rotations/new
  def new
    @rotation = Rotation.new
  end

  # GET /rotations/1/edit
  def edit
  end

  # POST /rotations
  # POST /rotations.json
  def create
    @rotation = Rotation.new(rotation_params)

    respond_to do |format|
      if @rotation.save
        format.html { redirect_to @rotation, notice: 'Rotation was successfully created.' }
        format.json { render :show, status: :created, location: @rotation }
      else
        format.html { render :new }
        format.json { render json: @rotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rotations/1
  # PATCH/PUT /rotations/1.json
  def update
    respond_to do |format|
      if @rotation.update(rotation_params)
        format.html { redirect_to event_day_path(@day), notice: 'Rotation was successfully updated.' }
        format.json { render :show, status: :ok, location: @rotation }
      else
        format.html { render :edit }
        format.json { render json: @rotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rotations/1
  # DELETE /rotations/1.json
  def destroy
    @rotation.destroy
    respond_to do |format|
      format.html { redirect_to rotations_url, notice: 'Rotation was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rotation
      @rotation = Rotation.includes(:job).includes(:day).find(params[:id])
      @job = @rotation.job
      @day = @rotation.day
    end

    def assigned_vols
      vols = []
      @day.shifts.where.not(volunteer_id: nil).each do |shift|
        vols << shift.volunteer.id
      end
      return vols
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rotation_params
      params.require(:rotation).permit( :id,
                                   :length,
                                   :start_time,
                                   :count,
                                   :shift_manager_id,
                                   shifts_attributes: [:id, :volunteer_id, :length, :start_time, :count, :_destroy])
    end
end
