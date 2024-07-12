class Api::BudgetPeriodsController < ApplicationController
  before_action :set_budget_period, only: %i[show]

  include Api::ResponseBuilder

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

    data = { budgetPeriod: @budget_period.serialized_hash }
    render json: build_response(data, status: :SUCCESS)
  end

  def show_last
    last_budget = current_user.budget_periods.order(:created_at).last

    if last_budget.nil?
      data = { messages: ['this user does not have budget periods'] }
      render json: build_response(data, status: :SUCCESS) and return
    end

    data = { budgetPeriod: last_budget.serialized_hash }
    render json: build_response(data, status: :SUCCESS)
  end

  private

  def set_budget_period
    @budget_period = current_user.budget_periods.find_by(uid: params[:uid])
  end
end
