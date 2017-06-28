module ApplicationHelper

  # Creates bootstrap classes for simple flash messages
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  # Creates flash messages
  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} show") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end

  # Creates active class for menu links
  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end   


  # Adds Devise resource to each controller / view
  def resource_name
    :user
  end

  # Adds Devise resource to each controller / view
  def resource
    @resource ||= User.new
  end

  # Adds Devise resource to each controller / view
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end  
  
end
