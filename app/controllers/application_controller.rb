class ApplicationController < ActionController::Base
  # Airbrake throwing "ActionController::InvalidAuthenticityToken" error for some users
  # https://stackoverflow.com/questions/38331496/rails-5-actioncontrollerinvalidauthenticitytoken-error
  protect_from_forgery prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_current_event

  # Makes the 'better errors' page run faster in development
  # https://github.com/charliesome/better_errors/issues/341
  before_action :better_errors_hack, if: -> { Rails.env.development? }

  def better_errors_hack
    request.env['puma.config'].options.user_options.delete :app
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

  # TODO this is terrible and only to be used for launch with Strawberry
  def set_current_event
    @current_event = Event.last
  end  

end
