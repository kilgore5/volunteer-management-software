class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_current_event

  # Makes the 'better errors' page run faster in development
  # https://github.com/charliesome/better_errors/issues/341
  before_action :better_errors_hack, if: -> { Rails.env.development? }

  def better_errors_hack
    request.env['puma.config'].options.user_options.delete :app
  end


  def after_sign_in_path_for(resource)
 
    # save list if there is a temp_list in the session
    if session[:application].present?
 
      # save list
      @application = current_user.applications.create(session[:application]["application"])
 
      # clear session
      session[:application] = nil
 
      #redirect
      flash[:notice] = "Sweet, logged in. Nice application, btw :)"      
      edit_user_path(@current_user)
 
    else
      #if there is not temp application in the session proceed as normal
      super
    end
 
  end

  protected

    # Allows our own custom params to go through for Devise models
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update) do |user_params|
        user_params.permit(:first_name,
                           :last_name,
                           :password,
                           :password_confirmation,
                           :current_password,
                           :email,
                           :birthday,
                           :mobile_number,
                           skills_attributes: [:id, :name, :proof_document, :_destroy])
      end
    end

  private

    #stops user from viewing a page if they don't have client access
    def client_and_up  
      if can? :manage, :all
        return
      else
        redirect_to root_url
      end
    end

    #Redirects user to registration instead of login
    def authenticate_user!
      if user_signed_in?
        super
      else
        redirect_to new_user_registration_path
      end
    end  

  # TODO this is terrible and only to be used for launch with Strawberry
  def set_current_event
    @current_event = Event.last
  end  

end
