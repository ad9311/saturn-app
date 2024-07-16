class Api::BudgetsController < ApplicationController
  before_action :set_budget, only: %i[show]

  include Api::ResponseBuilder

  def index
    # TODO: render errors
    by, direction = params[:order]&.split(':')
    ordered = order_data(current_user.budgets, by:, direction:)
    limited = limit_data(ordered, limit: params[:limit])
    serialized = limited.map(&:serialized_hash)

    data = { budgets: serialized }
    render json: build_response(data, status: :SUCCESS)
  end

  def show
    if @budget.nil?
      data = { messages: ['budget not found'] }
      render(json: build_response(data, status: :ERROR), status: :not_found) and return
    end

    @budget_hash = @budget.serialized_hash
    include_params = params[:include]&.split(':') || []
    expenses = include_params.any?('expenses')
    income = include_params.any?('income')

    include_transactions(expenses, income)

    data = { budget: @budget_hash }
    render json: build_response(data, status: :SUCCESS)
  end

  def show_last
    @budget = current_user.budgets.order(:created_at).last

    if @budget.nil?
      data = { messages: ['this user does not have budgets'] }
      render json: build_response(data, status: :SUCCESS) and return
    end

    @budget_hash = @budget.serialized_hash
    include_params = params[:include]&.split(':') || []
    expenses = include_params.any?('expenses')
    income = include_params.any?('income')

    include_transactions(expenses, income)

    data = { budget: @budget_hash }
    render json: build_response(data, status: :SUCCESS)
  end

  private

  def set_budget
    @budget = current_user.budgets.find_by(uid: params[:uid])
  end

  def include_transactions(expenses, income)
    expenses_hash = expenses && @budget.expense_transactions
                                       .joins(:expense_category)
                                       .includes(:expense_category)
                                       .map(&:serialized_hash)
    income_hash = @budget.income_transactions.map(&:serialized_hash) if income

    @budget_hash = @budget_hash.merge({ expenses: expenses_hash }) if expenses_hash
    @budget_hash = @budget_hash.merge({ income: income_hash }) if income_hash
  end
end
