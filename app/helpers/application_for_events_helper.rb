module ApplicationForEventsHelper

  # https://pupeno.com/2010/08/29/show-a-devise-log-in-form-in-another-page/
  # allows Devise form to be used in the 'application' to create a new user
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end  
  
end
