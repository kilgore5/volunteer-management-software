class ApplicationForEventsController < ApplicationController

  # Make sure not to filter 'create' as we'll be handling that with our redirect
  before_action :sign_me_up
  before_action :client_and_up, only: [:index]
  before_action :set_event, except: [:approve, :show]
  before_action :set_application, only: [:show, :update, :approve, :edit]
  before_action :set_user, only: [:new, :create, :update, :edit]
  # before_action :ensure_current_user_owns_application, only: [:edit, :update, :destroy]
  helper_method :sort_column, :sort_direction


  def new
    @application = ApplicationForEvent.new
    @application.user = @current_user
  end

  def show
  end

  # POST /events
  # POST /events.json
  def create

    # Creates the customer via Stripe API
    customer = StripeTool.create_customer(email: @current_user.email, 
                                            stripe_token: params[:stripeToken])
    # Sets the user's Stripe Account ID
    @current_user.update_attributes(stripe_customer_id: customer.id)
    # Creates the charge for the t-shirt
    # charge = StripeTool.create_charge(customer_id: customer.id, 
    #                                 amount: @amount,
    #                                 description: @description)
    @application = ApplicationForEvent.new(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to application_for_event_submitted_path(@application), notice: 'Application was successfully submitted.' }
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
        format.html { redirect_to edit_user_path(@current_user), notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: @application }
        format.js { flash.now[:notice] = "Application successfully rated" }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
        format.js { flash.now[:notice] = "Application rating failed - reload and try again." }
      end
    end
  end

  def submitted
    @application = ApplicationForEvent.find(params[:application_for_event_id])
  end  

  def index
    @applications = ApplicationForEvent
      .where(event_id: @event.id)
      .includes(:event, :user)
      .paginate(:page => params[:page])
    if use_references?
      @applications = @applications.references(:users)
    end
    @applications = @applications.order(sort_column + " " + sort_direction)

    @count = @applications.count
  end

  def approve
    @application.update_attributes(:accepted => true)
    respond_to do |format|
        format.js
    end    
  end

  private

    def use_references?
      params[:sort] == "users.last_name"
    end

    def sort_column
      if params[:sort] == "users.last_name"
        "LOWER(users.last_name)"
      else
        ApplicationForEvent.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
      end
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_user
      @current_user = current_user
    end  

    def set_event
      @event = params[:event_id] ? Event.friendly.find(params[:event_id]) : @current_event
      @description = @event.initial_charge_description ? @event.initial_charge_description : "T Shirt for volunteering"
      @amount = @event.initial_charge_cents ? @event.initial_charge_cents : 1500
    end

    def set_application
      @application = ApplicationForEvent.find(params[:id])
    end

    def ensure_current_user_owns_application
      if !(@current_user == @application.user)
        flash[:notice] = "You cannot access that page"
        redirect_to root_url
      end
    end

    # Redirects user to registration instead of login
    def sign_me_up
      if user_signed_in?
        return
      else
        redirect_to new_user_registration_path(ref: "apply")
      end
    end  

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application_for_event).permit(
                      :user_id,
                      :event_id,
                      :name,
                      :info,
                      :friends_or_referrals,
                      :been_before,
                      :volunteered_before,
                      :terms_accepted,
                      :stripe_token,
                      :rating,
                      preferred_job_ids: [],
                      user_attributes: [ :id,
                                              :first_name,
                                              :last_name,
                                              :email,
                                              :mobile_number,
                                              :birthday,
                                              :description,
                                              :medical_conditions,
                                              :_destroy,
                                              preferred_department_ids: [],                                              
                                              skills_attributes: [  :name,
                                                                    :id,
                                                                    :proof_document,
                                                                    :_destroy
                                                                  ],
                                              emergency_contact_attributes: [ :name,
                                                                              :id,
                                                                              :phone_number,
                                                                              :relationship,
                                                                              :_destroy
                                                                            ]
                                              ]                                              
                      )
    end    

end
