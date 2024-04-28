module ApplicationHelper
  def sliding_menu_links
    [
      { label: 'Home', path: home_index_path },
      { label: 'Budgets', path: budget_periods_path }
    ]
  end
end
