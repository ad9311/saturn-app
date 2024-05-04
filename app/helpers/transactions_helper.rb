module TransactionsHelper
  def transaction_breadcrumb(budget_period, last_path)
    [
      { body: t('views.budget_periods.title_short'), path: budget_periods_path },
      { body: budget_period.display_period_short(' '), path: budget_period_path(budget_period.uid) },
      { body: t('views.budget_periods.details'), path: budget_period_details_path(budget_period.uid) },
      { body: last_path }
    ]
  end

  def categories_chart_breadcrum(budget_period)
    [
      { body: t('views.budget_periods.title_short'), path: budget_periods_path },
      { body: budget_period.display_period_short(' '), path: budget_period_path(budget_period.uid) },
      { body: t('views.budget_periods.details'), path: budget_period_details_path(budget_period.uid) },
      { body: t('views.transactions.expenses.categories_chart.title') }
    ]
  end
end
