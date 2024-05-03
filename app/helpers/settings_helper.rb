module SettingsHelper
  def settings_links
    [
      { body: t('views.settings.links.expense_categories'), path: expense_categories_path }
    ]
  end
end
