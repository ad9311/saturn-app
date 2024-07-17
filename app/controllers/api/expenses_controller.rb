class Api::ExpensesController < ApplicationController
  before_action :set_budget

  include Api::ResponseBuilder

  def create
    expense = @budget.expenses.build(expense_params)
    if expense.save
      data = { expense: expense.serialized_hash, budget: @budget.serialized_hash(incomes: true, expenses: true) }
      render json: build_response(data, status: :SUCCESS), status: :created
    else
      render json: build_response(nil, status: :ERROR), status: :bad_request
    end
  end

  private

  def set_budget
    @budget = Budget.find_by(uid: params[:budget_uid])
  end

  def expense_params
    params.require(:expense).permit(:description, :expense_category_id, :amount)
  end
end
