module ApplicationHelper
  def navigation_links
    [
      { body: t('views.shared.navigation_links.home'), path: home_index_path },
      { body: t('views.shared.navigation_links.budget_periods'), path: budget_periods_path }
    ]
  end
end
