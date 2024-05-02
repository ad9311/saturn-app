class RenameLanguageToLocaleInUserSettings < ActiveRecord::Migration[7.1]
  def change
    rename_column :user_settings, :language, :locale
  end
end
