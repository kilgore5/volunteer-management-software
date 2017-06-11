class ApplicationForEventsController < ApplicationController

  # Make sure not to filter 'create' as we'll be handling that with our redirect
  before_action :authenticate_user!, :except => [:show, :index, :create]


  before_action :set_event, except: [:approve, :show]
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

    # Check to see if the user is registered/logged in
    if current_user.nil?
       # Store the form data in the session so we can retrieve it after login
       session[:application] = params
       # Redirect the user to register/login
       redirect_to new_user_registration_path    
   
    else    
      # @application = @event.applications.build(volunteer_id: @current_user.id)
      @application = current_user.applications.create(session[:application]["application"])

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
    @applications = ApplicationForEvent.where(event_id: @event.id).includes(:event, :volunteer)
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
      @event = params[:event_id] ? Event.friendly.find(params[:event_id]) : @current_event
    end

    def set_application
      @application = ApplicationForEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application_for_event).permit(
                      :name,
                      :start_time,
                      :end_time,
                      :event_length,
                      :ticket_price_cents,
                      :client_owner_id,
                      :info,
                      volunteer_attributes: [ :id,
                                              :first_name,
                                              :last_name,
                                              :email,
                                              :mobile_number,
                                              :birthday,
                                              :description,
                                              :_destroy,
                                              skills_attributes: [  :name,
                                                                    :proof_document,
                                                                    :_destroy
                                                                  ]
                                              ]
                      )
    end    

end
