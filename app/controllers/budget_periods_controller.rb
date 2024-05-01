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
    @render_path = 'budget_period_table_row'
    @rows = current_user.budget_periods.order(uid: :desc).map { |budget_period| { budget_period: } }
  end

  def show; end

  def details
    @income_table_columns = %w[Edit Description Amount Date Delete]
    @expense_table_columns = %w[Edit Description Category Amount Date Delete]
    @income_render_path = 'income_transactions/income_table_row'
    @expense_render_path = 'expense_transactions/expense_table_row'
    @income_rows = @budget_period.income_transactions.order(created_at: :desc).map do |income|
      { income:, budget_period: @budget_period }
    end
    @expense_rows = @budget_period.expense_transactions.order(created_at: :desc).map do |expense|
      { expense:, budget_period: @budget_period }
    end
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
