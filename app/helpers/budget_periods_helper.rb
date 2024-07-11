module BudgetPeriodsHelper
  def budget_period_index_table_columns
    [
      t('views.budget_periods.table.more'),
      t('views.budget_periods.table.date'),
      t('views.budget_periods.balance'),
      t('views.budget_periods.total_income_short'),
      t('views.budget_periods.total_expenses_short'),
      t('views.budget_periods.transaction_count_short'),
      t('views.budget_periods.income_count_short'),
      t('views.budget_periods.expense_count_short')
    ]
  end

  def budget_period_details_income_table_columns
    [
      t('views.budget_periods.table.edit'),
      t('views.budget_periods.table.transaction_description'),
      t('views.budget_periods.table.transaction_amount'),
      t('views.budget_periods.table.date'),
      t('views.budget_periods.table.delete')
    ]
  end

  def budget_period_details_expense_table_columns
    [
      t('views.budget_periods.table.edit'),
      t('views.budget_periods.table.transaction_description'),
      t('views.budget_periods.table.expense_category'),
      t('views.budget_periods.table.transaction_amount'),
      t('views.budget_periods.table.date'),
      t('views.budget_periods.table.delete')
    ]
  end

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
      },
      {
        body: t('views.budget_periods.charts.expense_category'),
        path: budget_expenses_categories_chart_path(budget_period.uid)
      }
    ]
  end

  module Charts
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
end
