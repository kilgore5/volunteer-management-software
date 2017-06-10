class ApplicationForEventsController < ApplicationController

  before_action :set_event, except: [:approve]
  before_action :set_application, only: [:show, :update, :approve]
  before_action :set_user, only: [:new, :create, :update]

  def new
    # proceed to creating application if user exists, otherwise signup with Devise
    if @current_user
      @application = @event.applications.build(volunteer_id: @current_user.id)
      @application.save
    else
      # @application = @event.applications.build()
      @application = ApplicationForEvent.new(event_id: @current_event.id)
    end
  end

  def show
  end

  # POST /events
  # POST /events.json
  def create
    # @application = @event.applications.build(volunteer_id: @current_user.id)
    @application = @event.applications.build()

    respond_to do |format|
      if @application.save
        format.html { redirect_to edit_user_path(@current_user), notice: 'Application was successfully submitted.' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to edit_user_path(@current_user), notice: 'Application was successfully submitted.' }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @applications = ApplicationForEvent.where(event_id: params[:event_id]).includes(:event, :volunteer)
  end

  def approve
    @application.update_attributes(:accepted => true)
    respond_to do |format|
        format.js
    end    
  end

  private

    def set_user
      @current_user = current_user
    end  

    def set_event
      @event = params[:event_id] ? Event.find(params[:event_id]) : @current_event
    end

    def set_application
      @application = ApplicationForEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.permit(  :name,
                      :start_time,
                      :end_time,
                      :event_length,
                      :ticket_price_cents,
                      :client_owner_id,
                      volunteer_attributes: [ :id,
                                              :title,
                                              :description,
                                              :_destroy])
    end    

end
