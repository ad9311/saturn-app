class SettingsController < ApplicationController
  def index; end

  def update_locale
    current_user.setting.update(locale_params)

    redirect_to settings_path
  end

  private

  def locale_params
    params.require(:setting).permit(:locale)
  end
end
