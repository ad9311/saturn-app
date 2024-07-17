class Api::ExpenseCategoriesController < ApplicationController
  include Api::ResponseBuilder

  def index
    expense_categories = current_user.expense_categories
                                     .where(default: false)
                                     .order(:name)
                                     .map(&:serialized_hash)
    data = { expenseCategories: expense_categories }
    render json: build_response(data, status: :SUCCESS)
  end
end
