module ApplicationHelper
  include ActionView::Helpers

  def navigation_links
    [
      { body: t('views.shared.navigation_links.home'), path: home_index_path },
      { body: t('views.shared.navigation_links.budget_periods'), path: budget_periods_path },
      { body: t('views.shared.navigation_links.todo_lists'), path: todo_lists_path }
    ]
  end

  def currency(number)
    number_to_currency(
      number,
      unit: t('views.shared.currency.unit'),
      separator: t('views.shared.currency.separator'),
      delimiter: t('views.shared.currency.delimiter')
    )
  end
end
