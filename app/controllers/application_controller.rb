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

  def set_current_event
    @current_event = Event.last
  end  

end
