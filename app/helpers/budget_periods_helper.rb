module BudgetPeriodsHelper
  def budget_period_breadcrumb_show(budget_period)
    [
      { body: 'Budgets', path: budget_periods_path },
      { body: budget_period.display_period_short(' ') }
    ]
  end

  def budget_period_breadcrumb_details(budget_period)
    [
      { body: 'Budgets', path: budget_periods_path },
      { body: budget_period.display_period_short(' '), path: budget_period_path(budget_period.uid) },
      { body: 'Details' }
    ]
  end
end
