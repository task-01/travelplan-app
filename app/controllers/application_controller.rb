class ApplicationController < ActionController::Base
  before_action :set_common_variable
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_out_path_for(resource)
    root_path
  end
  def set_common_variable
    @client = OpenAI::Client.new(access_token: ENV["CHATGPT_API_KEY"])
  end

  def configure_permitted_parameters
    added_attrs = [:email, :name, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end
end
