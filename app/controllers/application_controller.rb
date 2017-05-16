class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

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

end
