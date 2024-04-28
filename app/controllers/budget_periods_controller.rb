class BudgetPeriodsController < ApplicationController
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
    @budget_periods = current_user.budget_periods.order(uid: :desc).map do |budget_period|
      [
        { partial: 'shared/table/table_link', options: { text: 'Show', path: "/budgets/#{budget_period.uid}" } },
        { data: budget_period.display_period_short },
        { data: budget_period.balance },
        { data: budget_period.total_income },
        { data: budget_period.total_expenses },
        { data: budget_period.transaction_count },
        { data: budget_period.income_count },
        { data: budget_period.expense_count }
      ]
    end
  end

  def show
    @balance_summary = [
      { label: 'Balance', data: @budget_period.balance },
      { label: 'Total income', data: @budget_period.total_income },
      { label: 'Total expenses', data: @budget_period.total_expenses }
    ]
    @transaction_summary = [
      { label: 'Transactions', data: @budget_period.transaction_count },
      { label: 'Income', data: @budget_period.income_count },
      { label: 'Expenses', data: @budget_period.expense_count }
    ]
  end

  def details
    @income_table_columns = %w[Description Amount Date]
    @expense_table_columns = %w[Description Category Amount Date]
    @income = @budget_period.income_transactions.order(created_at: :desc).map do |income|
      [
        { data: income.description },
        { data: income.amount },
        { data: income.created_at }
      ]
    end
    @expenses = @budget_period.expense_transactions.order(created_at: :desc).map do |expense|
      [
        { data: expense.description },
        { data: expense.expense_category.name },
        { data: expense.amount },
        { data: expense.created_at }
      ]
    end
  end

  private

  def set_budget_period
    @budget_period = BudgetPeriod.find_by(uid: params[:uid])
  end
end
