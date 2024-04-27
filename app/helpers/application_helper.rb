module ApplicationHelper
  def sliding_menu_links
    [
      { label: 'Home', path: home_index_path },
      { label: 'Budgets', path: budgets_path }
    ]
  end
end
