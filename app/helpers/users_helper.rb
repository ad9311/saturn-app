module UsersHelper
  def settings_links
    [
      { body: 'Expense categories', path: expense_categories_path }
    ]
  end
end
