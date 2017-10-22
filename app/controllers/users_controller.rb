class UsersController < ApplicationController
  before_action :authenticate_user!
  # Only allows access if use has correct role
  before_action :client_and_up, only: [:index, :show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :stripe_customer, only: [:show, :edit]
  before_action :get_apps, only: [:show, :edit]
  layout "account", only: [:show, :edit, :update]

  # GET /users
  # GET /users.json
  def index
    # @users = User.all
    @managers = User.with_role(:shift_manager)
    @volunteers = User.with_role(:volunteer)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @recently_accepted = @apps.accepted.where('updated_at >= ?', 2.months.ago).count
    if @recently_accepted > 0 && flash.empty?
      flash[:notice] = "You have an accepted application pending your confirmation! Your spot is not secure until you confirm your intent to attend your shifts."
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to edit_user_path(@user), notice: 'Your profile was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    if params[:stripeToken]
    # User is updating their card details
      if @user.stripe_customer_id
        #User is in Stripe, retrieve them
        customer = StripeTool.find_customer(@user.stripe_customer_id)
        # Adds The New Card
        card = StripeTool.add_card(customer, params[:stripeToken])

        error = card[:error] ? card[:error][:message] : nil

        # Don't proceed without a valid card
        if error
          redirect_to edit_user_path(@user), flash: { "alert-warning": "Oops, something went wrong; please check the details and try again#{error ? '. (Card error: ' + error + ')' : ''}" }
          return
        else
          # Continue
        end
      else
        # Creates the customer via Stripe API
        customer = StripeTool.create_customer(@user.email, params[:stripeToken])
        # Sets the user's Stripe Account ID
        @user.update_attributes(stripe_customer_id: customer.id)
      end
    end
      
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_user_path(@user), notice: 'Your profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Your profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end

    def stripe_customer
      @customer = @user.stripe_customer_id ? StripeTool.find_customer(@user.stripe_customer_id) : nil
    end

    def get_apps
      @apps = @user.applications.includes(:event)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name,
                                   :avatar,
                                   :last_name,
                                   :email,
                                   :birthday,
                                   :mobile_number,
                                   :password,
                                   :password_confirmation,
                                   :current_password,
                                   skills_attributes: [:id, :name, :proof_document, :_destroy])
    end

end
