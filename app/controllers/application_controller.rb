class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session

  prepend_before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:identity])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:nickname,
                                             :firstname,
                                             :lastname,
                                             :cellphone,
                                             :zipcode,
                                             :address,
                                             :company,
                                             :company_address,
                                             :job_title])
  end
end
