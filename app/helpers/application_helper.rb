module ApplicationHelper
  def navigation_links
    [
      { label: 'Home', path: home_index_path },
      { label: 'Budgets', path: budget_periods_path },
      { label: 'Settings', path: user_settings_path }
    ]
  end

  def settings_links
    [
      { body: 'Expense categories', path: expense_categories_path }
    ]
  end
end
