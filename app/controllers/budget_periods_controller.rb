class BudgetPeriodsController < ApplicationController
  before_action :set_budget_period, only: %i[show]

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
        "/budgets/#{budget_period.uid}",
        budget_period.display_period_short,
        budget_period.balance,
        budget_period.total_income,
        budget_period.total_expenses,
        budget_period.transaction_count,
        budget_period.income_count,
        budget_period.expense_count
      ]
    end
  end

  def show
    @income_table_columns = %w[Description Amount Date]
    @expense_table_columns = %w[Description Category Amount Date]
    @expenses = @budget_period.order(created_at: :desc).map do |expense|
      []
    end
  end

  private

  def set_budget_period
    @budget_period = BudgetPeriod.find_by(uid: params[:uid])
  end
end
