class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # check to see if you are at a specific page.
  
  def current_controller?(names)
    names.include?(params[:controller])
  end
  helper_method :current_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password,
      :password_confirmation, :remember_me, :avatar, :avatar_cache])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password,
      :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar])
  end

end
