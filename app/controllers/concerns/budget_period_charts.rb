module BudgetPeriodCharts
  def generate_chart_history(budget_periods, selector = nil)
    case selector&.to_sym
    when :balance
      balance_data = balance_history(budget_periods)
      [{ name: t('views.budget_periods.charts.balance'), data: balance_data }]
    when :income
      income_data = income_history(budget_periods)
      [{ name: t('views.budget_periods.charts.income'), data: income_data }]
    when :expense
      expense_data = expense_history(budget_periods)
      [{ name: t('views.budget_periods.charts.expense'), data: expense_data }]
    else
      all_history(budget_periods)
    end
  end

  private

  def balance_history(budget_periods)
    budget_periods.map do |bp|
      ["#{bp.month.to_s.rjust(2, '0')}/#{bp.year}", bp.balance.to_f]
    end
  end

  def income_history(budget_periods)
    budget_periods.map do |bp|
      ["#{bp.month.to_s.rjust(2, '0')}/#{bp.year}", bp.total_income.to_f]
    end
  end

  def expense_history(budget_periods)
    budget_periods.map do |bp|
      ["#{bp.month.to_s.rjust(2, '0')}/#{bp.year}", bp.total_expenses.to_f]
    end
  end

  def all_history(budget_periods)
    [
      { name: t('views.budget_periods.charts.balance'), data: balance_history(budget_periods) },
      { name: t('views.budget_periods.charts.income'), data: income_history(budget_periods) },
      { name: t('views.budget_periods.charts.expense'), data: expense_history(budget_periods) }
    ]
  end
end
