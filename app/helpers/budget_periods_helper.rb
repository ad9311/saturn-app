module BudgetPeriodsHelper
  def budget_period_breadcrumb_show(budget_period)
    [
      { body: t('views.budget_periods.title_short'), path: budget_periods_path },
      { body: budget_period.display_period_short(' ') }
    ]
  end

  def budget_period_breadcrumb_details(budget_period)
    [
      { body: t('views.budget_periods.title_short'), path: budget_periods_path },
      { body: budget_period.display_period_short(' '), path: budget_period_path(budget_period.uid) },
      { body: t('views.budget_periods.details') }
    ]
  end

  def budget_period_show_nav_links(budget_period)
    [
      { body: t('views.budget_periods.full_details'), path: budget_period_details_path(budget_period.uid) },
      { body: t('views.budget_periods.forms.add_income'), path: new_budget_income_transaction_path(budget_period.uid) },
      {
        body: t('views.budget_periods.forms.add_expense'),
        path: new_budget_expense_transaction_path(budget_period.uid)
      }
    ]
  end

  def budget_period_details_nav_links(budget_period)
    [
      { body: t('views.budget_periods.forms.add_income'), path: new_budget_income_transaction_path(budget_period.uid) },
      {
        body: t('views.budget_periods.forms.add_expense'),
        path: new_budget_expense_transaction_path(budget_period.uid)
      }
    ]
  end
end
