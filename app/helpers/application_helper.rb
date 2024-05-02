module ApplicationHelper
  def navigation_links
    [
      { body: 'Home', path: home_index_path },
      { body: 'Budgets', path: budget_periods_path },
      { body: 'Settings', path: settings_path }
    ]
  end
end
