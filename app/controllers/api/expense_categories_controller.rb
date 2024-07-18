class Api::ExpenseCategoriesController < ApplicationController
  include Api::ResponseBuilder

  def index
    expense_categories = current_user.expense_categories
                                     .where(default: false)
                                     .order(:name)
                                     .map(&:serialized_hash)
    data = { expense_categories: }
    render json: build_response(data, status: :SUCCESS)
  end

  def create
    expense_category = current_user.expense_categories.build(expense_category_params)
    if expense_category.save
      expense_categories = current_user.expense_categories
                                       .where(default: false)
                                       .order(:name)
                                       .map(&:serialized_hash)
      data = { expense_categories: }
      render json: build_response(data, status: :SUCCESS), status: :created
    else
      render json: build_error_response([], status: :ERROR)
    end
  end

  private

  def expense_category_params
    params.require(:expense_category).permit(:name, :color)
  end
end
