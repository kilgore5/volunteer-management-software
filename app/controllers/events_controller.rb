class EventsController < ApplicationController
  # load_and_authorize_resource
  # Basic Devise authentication
  before_action :authenticate_user!
  # Only allows access if use has correct role
  before_action :client_and_up
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event_days = @event.event_days
    @days_by_date = @event_days.group_by(&:date)
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    # Get all the event_days as well for each request
    def set_event
      @event = Event.includes(:event_days).friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :start_time, :end_time, :event_length, :ticket_price_cents, :client_owner_id,
                                    jobs_attributes: [:id, :title, :description, :rotations_required_per_day, :workers_per_rotation, :hours_per_rotation, :_destroy,
                                    skill_requirements_attributes: [:id, :title, :description, :_destroy]
                                    ])
    end
end
