class Api::BudgetPeriodsController < ApplicationController
  include Api::ResponseBuilder

  def index
    by, direction = params[:order]&.split(':')
    ordered = order_data(current_user.budget_periods, by:, direction:)
    limited = limit_data(ordered, limit: params[:limit])
    serialized = limited.map(&:serialized_hash)

    status = :OK
    data = { budget_periods: serialized }
    render json: build_response(status, data)
  end
end
