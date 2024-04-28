module TransactionsHelper
  def transaction_breadcrumb(budget_period, last_path)
    [
      { body: 'Budgets', path: budget_periods_path },
      { body: budget_period.display_period_short(' '), path: budget_period_path(budget_period.uid) },
      { body: 'Details', path: budget_period_details_path(budget_period.uid) },
      { body: last_path }
    ]
  end
end
