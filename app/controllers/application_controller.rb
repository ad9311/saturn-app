class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_setting

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  private

  def set_user_setting
    return unless user_signed_in?

    Setting.create(user: current_user) if current_user.setting.nil?
    I18n.locale = current_user.setting.locale || I18n.default_locale
  end
end
