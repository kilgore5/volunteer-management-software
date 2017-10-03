class AppliesController < ApplicationController

  # Devise
  before_action :authenticate_user!

  # Make sure not to filter 'create' as we'll be handling that with our redirect
  # before_action :sign_me_up
  before_action :client_and_up, only: [:index]
  before_action :set_event, except: [:approve, :show]
  before_action :set_application, only: [:show, :update, :approve, :edit, :accept_invitation, :decline_invitation]
  before_action :set_user, only: [:new, :create, :update, :edit]
  before_action :statuses, only: [:index]
  # before_action :ensure_current_user_owns_application, only: [:edit, :update, :destroy]
  helper_method :sort_column, :sort_direction


  def new
    @application = Apply.new
    @application.user = @current_user
  end

  def show
  end

  # POST /events
  # POST /events.json
  def create
    # Creates the customer via Stripe API
    customer = StripeTool.create_customer(@current_user.email, 
                                            params[:stripeToken])
    # Sets the user's Stripe Account ID
    @current_user.update_attributes(stripe_customer_id: customer.id)

    @application = Apply.new(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to apply_submitted_path(@application), notice: 'Application was successfully submitted.' }
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
    @application = Apply.find(params[:apply_id])
  end

  def index

    list_all

    # view all or paged
    if params[:view] == "all" or request.format.csv?
      @view_type = "all"
    else
      @view_type = "paged"
      @number_per_page = 30
      @applications = @applications.paginate(page: params[:page], per_page: @number_per_page)
    end

    @count = @applications.count

    @accepted = @applications.accepted.count

    @waitlisted = @applications.waitlisted.count

    @denied = @applications.denied.count

    @confirmed = @applications.confirmed.count

    if request.format.csv?
      send_data @applications.to_csv, 
                filename: "#{@event.name.parameterize}-applications-#{Date.today.strftime("%Y-%m-%d")}.csv"
    end

  end

  def approve
    @application.update_attributes(:accepted => true)
    respond_to do |format|
        format.js
    end
  end

  def accept_invitation

    @user = @application.user

    # Don't proceed without customer ID
    if @user.stripe_customer_id.nil?
      redirect_to edit_user_path(@user), flash: { "alert-warning": "It looks like we don't have your card details on file; please email us at volunteers.strawberry-fields.com.au" }
      return
    end

    # Finds the customer from Stripe
    customer = StripeTool.find_customer(@user.stripe_customer_id)

    failure = customer[:error] ? customer[:error][:message] : nil

    # Don't proceed without customer ID
    if failure
      redirect_to edit_user_path(@user), flash: { "alert-warning": "It looks like we don't have your card details on file; please email us at volunteers.strawberry-fields.com.au" }
      return
    else
      # Creates the charge for the t-shirt
      charge = StripeTool.create_charge(customer.id, 
                                        @amount,
                                        @description,
                                        params[:key])
    end

    error = charge[:error] ? charge[:error][:message] : nil

    unless error
      # Save it as a record to our DB
      Charge.create(
        user_id: @user.id,
        event_id: @event.id,
        amount_cents: @amount,
        description: @description,
        stripe_id: charge.id
      )
    end

    respond_to do |format|
      if !error && @application.confirm!
        format.html { redirect_to edit_user_path(@user), notice: 'Your volunteer position has been secured!' }
      else
        format.html { redirect_to edit_user_path(@user), flash: { "alert-warning": "Oops, something went wrong; please try again or contact our team#{error ? '. (payment error: ' + error + ')' : ''}" } }
      end
    end
  end

  def decline_invitation
    @user = @application.user
    respond_to do |format|
      if @application.destroy
        format.html { redirect_to edit_user_path(@user), notice: 'Your volunteer application has been removed.' }
        # TODO - Mailer
        # ApplicationResponseMailer.accepted_invitation_confirmation_email(@user, @application, @event).deliver_later
      else
        format.html { redirect_to edit_user_path(@user), flash: { "alert-warning": "Oops, something went wrong; please try again." } }
      end
    end
  end

  # Incomplete 
  # http://railscasts.com/episodes/165-edit-multiple?view=asciicast
  def edit_multiple
      
  end
    
  def update_multiple
     
  end

  def accept_multiple
    respond_to do |format|

      @approved_applications = Apply.where(id: params[:application_ids_accept])
      @denied_applications = Apply.where(id: params[:application_ids_deny])

      if Apply.where(id: params[:application_ids_accept]).each { |a| a.accept! } &&
         Apply.where(id: params[:application_ids_waitlist]).each { |a| a.waitlist! } &&
         Apply.where(id: params[:application_ids_deny]).each { |a| a.deny! }
        format.html { redirect_to request.referrer, notice: 'The applications have been processed!' }
      else
        format.html { redirect_to request.referrer, flash: { "alert-warning": "Oops, something went wrong; please try again." } }
      end
    end
  end

  private

    # Finds the apps given certain filters
    def list_all

      @applications = Apply
        .where(event_id: @event.id)
        .includes(:event, :user, :preferred_jobs)
      if use_references?
        @applications = @applications.references(:users)
      end
      # Search Form in use
      if params[:q] and !params[:q].empty?
        @applications = @applications
                        .joins(:user)
                        .where( "lower(users.full_name) like ?", "%#{params[:q].downcase}%" )
                        .or(
                          @applications
                          .joins(:user)
                          .where( "lower(users.email) like ?", "%#{params[:q].downcase}%" )
                        )
      end
      @applications = @applications.order(sort_column + " " + sort_direction)

      # Filters by the selected preferred jobs
      if params[:job] and !params[:job][:slug].empty?
        @applications = @applications.joins(:preferred_jobs).where(jobs: {slug: params[:job][:slug]})
      end

      # Filters by the status
      if params[:status] and !params[:status].empty?
        # If looking at 'accepted' apps, show those that are confirmed as well
        case params[:status]
          when "all_states"
            @applications = @applications
          when "accepted"
            # FIXME, this should show accepted and confirmed apps, using something similar to '.where( state: 'like'...)'
            # @applications = @applications.where(state: "accepted" or state: "confirmed")
            @applications = @applications.where(state: params[:status])
          else
            @applications = @applications.where(state: params[:status])
        end
      end

    end

    def use_references?
      params[:sort] == "users.last_name"
    end

    def sort_column
      if params[:sort] == "users.last_name"
        "LOWER(users.last_name)"
      elsif params[:sort] == "applies.accepted"
        "applies.state = 'accepted'"
      elsif params[:sort] == "applies.waitlisted"
        "applies.state"
      elsif params[:sort] == "applies.denied"
        "applies.state"
      elsif params[:sort]
        Apply.column_names.include?(params[:sort].tap{|s| s.slice!("applies.")}) ? "applies.#{params[:sort]}" : "applies.created_at"
      else
        "applies.created_at"
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
      @description = @event.initial_charge_description ? @event.initial_charge_description : "T Shirt for volunteer shift"
      @amount = @event.initial_charge_cents ? @event.initial_charge_cents : 1500
    end

    def set_application
      @application = Apply.find(params[:id])
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


    # Shows statuses to sort by
    def statuses
      @statuses = [
        "submitted",
        "accepted",
        "waitlisted",
        "denied",
        "confirmed"
      ]
    end 

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:apply).permit(
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
