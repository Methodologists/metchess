class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
before_action :configure_permitted_parameters, if: :devise_controller?

rescue_from ActiveRecord::RecordNotFound do
  flash[:warning] = 'Resource not found.'
  redirect_back_or root_path
end

def redirect_back_or(path)
  redirect_to request.referer || path
end

 protected

 def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up) << :username
 end
end