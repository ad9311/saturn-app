class RenameUserSettingsToSettings < ActiveRecord::Migration[7.1]
  def change
    rename_table :user_settings, :settings
  end
end
