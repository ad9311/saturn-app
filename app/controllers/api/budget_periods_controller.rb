class Api::BudgetPeriodsController < ApplicationController
  before_action :set_budget_period, only: %i[show]

  include Api::ResponseBuilder
  # include Api::BudgetPeriodsConcern

  def index
    # TODO: render errors
    by, direction = params[:order]&.split(':')
    ordered = order_data(current_user.budget_periods, by:, direction:)
    limited = limit_data(ordered, limit: params[:limit])
    serialized = limited.map(&:serialized_hash)

    data = { budgetPeriods: serialized }
    render json: build_response(data, status: :SUCCESS)
  end

  def show
    if @budget_period.nil?
      data = { messages: ['budget period not found'] }
      render(json: build_response(data, status: :ERROR), status: :not_found) and return
    end

    @budget_period_hash = @budget_period.serialized_hash
    include_params = params[:include]&.split(':') || []
    expenses = include_params.any?('expenses')
    income = include_params.any?('income')

    include_transactions(expenses, income)

    data = { budgetPeriod: @budget_period_hash }
    render json: build_response(data, status: :SUCCESS)
  end

  def show_last
    @budget_period = current_user.budget_periods.order(:created_at).last

    if @budget_period.nil?
      data = { messages: ['this user does not have budget periods'] }
      render json: build_response(data, status: :SUCCESS) and return
    end

    @budget_period_hash = @budget_period.serialized_hash
    include_params = params[:include]&.split(':') || []
    expenses = include_params.any?('expenses')
    income = include_params.any?('income')

    include_transactions(expenses, income)

    data = { budgetPeriod: @budget_period_hash }
    render json: build_response(data, status: :SUCCESS)
  end

  private

  def set_budget_period
    @budget_period = current_user.budget_periods.find_by(uid: params[:uid])
  end

  def include_transactions(expenses, income)
    expenses_hash = expenses && @budget_period.expense_transactions
                                              .joins(:expense_category)
                                              .includes(:expense_category)
                                              .map(&:serialized_hash)
    income_hash = @budget_period.income_transactions.map(&:serialized_hash) if income

    @budget_period_hash = @budget_period_hash.merge({ expenses: expenses_hash }) if expenses_hash
    @budget_period_hash = @budget_period_hash.merge({ income: income_hash }) if income_hash
  end
end
