class BudgetPeriodsController < ApplicationController
  # before_action :next_budget_period, only: :index
  before_action :set_budget_period, only: %i[show details]

  def index
    @table_columns = [
      t('views.shared.table.more'),
      t('views.shared.table.date'),
      t('views.budget_periods.balance'),
      t('views.budget_periods.total_income_short'),
      t('views.budget_periods.total_expenses_short'),
      t('views.budget_periods.transaction_count_short'),
      t('views.budget_periods.income_count_short'),
      t('views.budget_periods.expense_count_short')
    ]
    @render_path = 'budget_period_table_row'
    rows = current_user.budget_periods.order(uid: :desc).map { |budget_period| { budget_period: } }
    @rows = Kaminari.paginate_array(rows).page(params[:budgets_page])
  end

  def show; end

  def details
    @income_table_columns = [
      t('views.shared.table.edit'),
      t('views.transactions.description'),
      t('views.transactions.amount'),
      t('views.shared.table.date'),
      t('views.shared.table.delete')
    ]
    @expense_table_columns = [
      t('views.shared.table.edit'),
      t('views.transactions.description'),
      t('views.transactions.category'),
      t('views.transactions.amount'),
      t('views.shared.table.date'),
      t('views.shared.table.delete')
    ]
    @income_render_path = 'income_transactions/income_table_row'
    @expense_render_path = 'expense_transactions/expense_table_row'
    income_rows = @budget_period.income_transactions.order(created_at: :desc).map do |income|
      { income:, budget_period: @budget_period }
    end
    @income_rows = Kaminari.paginate_array(income_rows).page(params[:income_page])
    expense_rows = @budget_period.expense_transactions.order(created_at: :desc).map do |expense|
      { expense:, budget_period: @budget_period }
    end
    @expense_rows = Kaminari.paginate_array(expense_rows).page(params[:expense_page])
  end

  private

  def set_budget_period
    @budget_period = BudgetPeriod.find_by(uid: params[:uid])
  end

  def next_budget_period
    last_budget_period = current_user.budget_periods.order(uid: :desc).first
    current_date = Time.zone.now

    return if last_budget_period&.month == current_date.month && last_budget_period&.year == current_date.year

    current_user.budget_periods.create(month: current_date.month, year: current_date.year)
  end
end
