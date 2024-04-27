module ApplicationHelper
  def sliding_menu_links
    [
      { label: 'Home', path: home_index_path },
      { label: 'Something', path: home_index_path }
    ]
  end
end
