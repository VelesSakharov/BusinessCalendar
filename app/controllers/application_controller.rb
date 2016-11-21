class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :first_name, :last_name])

    rescue_from CanCan::AccessDenied do |exception|
      flash[:error] = "Access denied!"
      redirect_to root_url
    end
  end
end
