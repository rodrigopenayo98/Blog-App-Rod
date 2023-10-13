class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_default_response_format, if: :api_request?

  def after_sign_in_path_for(_resource)
    users_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def api_request?
    request.path.start_with?('/api/')
  end

  def set_default_response_format
    request.format = :json
  end
end
