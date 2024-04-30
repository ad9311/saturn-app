class ExpenseCategoriesController < ApplicationController
  before_action :set_expense_category, only: %i[edit update destroy]
  before_action :set_redirect_path, except: %i[index destroy]

  def index
    @table_columns = %w[Edit Name Color Delete]
    @row_data = {
      rows: current_user.expense_categories.where(default: false),
      render: 'shared/table_expense_category_row'
    }
  end

  def new
    @category = ExpenseCategory.new
  end

  def edit; end

  def create
    @category = current_user.expense_categories.build(expense_category_params)
    if @category.save
      redirect_to redirect_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(expense_category_params)
      redirect_to redirect_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy!

    redirect_to expense_categories_path
  end

  private

  def expense_category_params
    params.require(:expense_category).permit(:name, :color)
  end

  def set_expense_category
    @category = ExpenseCategory.find(params[:id])
  end

  def set_redirect_path
    @redirect_path = params[:redirect_path]
  end

  def redirect_path
    params[:redirect_path] || expense_categories_path
  end
end
