class ExpenseCategoriesController < ApplicationController
  before_action :set_expense_category, only: %i[edit update destroy]

  def index
    @table_columns = %w[Edit Name Color]
    @categories = current_user.expense_categories.map do |category|
      [
        { render: 'shared/table/table_link', options: { body: 'Edit', path: edit_expense_category_path(category) } },
        { data: category.name },
        { data: category.color },
        { render: 'shared/table/destroy_button', options: { path: expense_category_path(category) } }
      ]
    end
  end

  def new
    @category = ExpenseCategory.new
  end

  def edit; end

  def create
    @category = current_user.expense_categories.build(expense_category_params)
    if @category.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(expense_category_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy!

    redirect_to root_path
  end

  private

  def expense_category_params
    params.require(:expense_category).permit(:name, :color)
  end

  def set_expense_category
    @category = ExpenseCategory.find(params[:id])
  end
end
