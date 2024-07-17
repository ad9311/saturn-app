class Api::IncomesController < ApplicationController
  before_action :set_budget

  include Api::ResponseBuilder

  def create
    income = @budget.incomes.build(income_params)
    if income.save
      data = { income: income.serialized_hash, budget: @budget.serialized_hash(incomes: true, expenses: true) }
      render json: build_response(data, status: :SUCCESS), status: :created
    else
      render json: build_error_response([], status: :ERROR), status: :bad_request
    end
  end

  private

  def set_budget
    @budget = Budget.find_by(uid: params[:budget_uid])
  end

  def income_params
    params.require(:income).permit(:description, :amount)
  end
end
