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

    include_params = params[:include]&.split(':') || []
    expenses = include_params.any?('expenses')
    income = include_params.any?('income_list')

    data = { budget: @budget.serialized_hash(expenses:, incomes: income) }
    render json: build_response(data, status: :SUCCESS)
  end

  def show_last
    @budget = current_user.budgets.order(:created_at).last

    if @budget.nil?
      data = { messages: ['this user does not have budgets'] }
      render json: build_response(data, status: :SUCCESS) and return
    end

    include_params = params[:include]&.split(':') || []
    expenses = include_params.any?('expenses')
    income = include_params.any?('income_list')

    data = { budget: @budget.serialized_hash(expenses:, incomes: income) }
    render json: build_response(data, status: :SUCCESS)
  end

  private

  def set_budget
    @budget = current_user.budgets.find_by(uid: params[:uid])
  end
end
