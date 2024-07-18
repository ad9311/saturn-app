class Api::BudgetsController < ApplicationController
  before_action :set_budget, only: %i[show]

  include Api::ResponseBuilder
  include Api::BudgetsHelper::Errors

  def index
    by, direction = params[:order]&.split(':')
    unless correct_format_for_order?(by, direction)
      messages = ['incorrect format for order param']
      status = :ERROR_BAD_PARAM
      render(json: build_error_response(messages, status:), status: :bad_request) and return
    end

    unless correct_format_for_limit?(params[:limit])
      messages = ['incorrect format for limit param']
      status = :ERROR_BAD_PARAM
      render(json: build_error_response(messages, status:), status: :bad_request) and return
    end

    ordered = order_data(current_user.budgets, by:, direction:)
    limited = limit_data(ordered, limit: params[:limit])

    data = { budgets: limited.map(&:serialized_hash) }
    render json: build_response(data, status: :SUCCESS)
  end

  def show
    if @budget.nil?
      messages = ['budget not found for this user']
      status = :ERROR_NOT_FOUND
      render(json: build_error_response(messages, status:), status: :not_found) and return
    end

    include_params = params[:include]&.split(':') || []
    expenses = include_params.any?('expenses')
    income = include_params.any?('income_list')

    data = { budget: @budget.serialized_hash(expenses:, incomes: income) }
    render json: build_response(data, status: :SUCCESS)
  end

  def show_last
    budget = current_user.budgets.order(:created_at).last

    if budget.nil?
      data = { notice: ['user does not have budgets'] }
      render json: build_response(data, status: :SUCCESS) and return
    end

    include_params = params[:include]&.split(':') || []
    expenses = include_params.any?('expenses')
    income = include_params.any?('income_list')

    data = { budget: budget.serialized_hash(expenses:, incomes: income) }
    render json: build_response(data, status: :SUCCESS)
  end

  private

  def set_budget
    @budget = current_user.budgets.find_by(uid: params[:uid])
  end
end
