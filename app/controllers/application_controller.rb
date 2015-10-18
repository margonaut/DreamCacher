class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :avatar
    # devise_parameter_sanitizer.for(:sign_up) << :username
  end

  def layout_by_resource
    if devise_controller? && !user_signed_in?
      "devise"
    elsif params[:controller] == "analytics" && user_signed_in?
      "analytics"
    else
      "application"
    end
  end
end
