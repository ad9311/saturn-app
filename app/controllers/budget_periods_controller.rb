class BudgetPeriodsController < ApplicationController
  before_action :next_budget_period, only: :index
  before_action :set_budget_period, only: %i[show details]

  def index
    @table_columns = [
      'More',
      'Date',
      'Balance',
      'Total income',
      'Total expenses',
      'Transaction count',
      'Income count',
      'Expense count'
    ]
    @row_data = { rows: current_user.budget_periods.order(uid: :desc), render: 'shared/table_budget_period_row' }
  end

  def show
    @balance = @budget_period.balance
    @total_income = @budget_period.total_income
    @total_expenses = @budget_period.total_expenses
    @transaction_count = @budget_period.transaction_count
    @income_count = @budget_period.income_count
    @expense_count = @budget_period.expense_count
  end

  def details
    @income_table_columns = %w[Edit Description Amount Date Delete]
    @expense_table_columns = %w[Edit Description Category Amount Date Delete]
    @income = @budget_period.income_transactions.order(created_at: :desc).map do |income|
      [
        {
          render: 'shared/table/table_link',
          options: { body: 'Edit', path: edit_budget_income_transaction_path(@budget_period.uid, income.id) }
        },
        { data: income.description },
        { data: income.amount },
        { data: income.created_at },
        {
          render: 'shared/table/destroy_button',
          options: { path: budget_income_transaction_path(@budget_period.uid, income.id) }
        }
      ]
    end
    @expenses = @budget_period.expense_transactions.order(created_at: :desc).map do |expense|
      [
        {
          render: 'shared/table/table_link',
          options: { body: 'Edit', path: edit_budget_expense_transaction_path(@budget_period.uid, expense.id) }
        },
        { data: expense.description },
        { data: expense.expense_category.name },
        { data: expense.amount },
        { data: expense.created_at },
        {
          render: 'shared/table/destroy_button',
          options: { path: budget_expense_transaction_path(@budget_period.uid, expense.id) }
        }
      ]
    end
  end

  private

  def set_budget_period
    @budget_period = BudgetPeriod.find_by(uid: params[:uid])
  end

  def next_budget_period
    last_budget_period = current_user.budget_periods.order(uid: :desc).first
    current_date = Time.zone.now

    return if last_budget_period.month == current_date.month && last_budget_period.year == current_date.year

    current_user.budget_periods.create(month: current_date.month, year: current_date.year)
  end
end
