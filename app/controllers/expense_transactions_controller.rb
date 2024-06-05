class ExpenseTransactionsController < ApplicationController
  before_action :set_budget_period
  before_action :set_expense, only: %i[edit update destroy]
  before_action :set_create_form_path, :set_expense_categories, only: %i[new create]
  before_action :set_update_form_path, :set_expense_categories, only: %i[edit update]
  before_action :set_expense_categories, only: %i[new create edit update]

  def new
    @expense = ExpenseTransaction.new
  end

  def edit; end

  def create
    @expense = @budget_period.expense_transactions.build(expense_params)
    if @expense.save
      redirect_to budget_period_details_path(@budget_period.uid)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @expense.update(expense_params)
      redirect_to budget_period_details_path(@budget_period.uid)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy!

    redirect_to budget_period_details_path(@budget_period.uid)
  end

  def categories_chart
    query = 'expense_categories.name, expense_categories.color, SUM(expense_transactions.amount) AS total'
    categories_data = ExpenseCategory.select(query)
                                     .joins(:expense_transactions)
                                     .where(expense_transactions: { budget_period_id: @budget_period.id })
                                     .group(:name, :color)
                                     .sort_by(&:total)
                                     .reverse
    @categories_data = categories_data.map do |category_data|
      [category_data.name, category_data.total.to_f]
    end
    @colors = categories_data.map(&:color)
  end

  private

  def set_budget_period
    @budget_period = BudgetPeriod.find_by(uid: params[:budget_uid])
  end

  def set_expense
    @expense = ExpenseTransaction.find(params[:id])
  end

  def expense_params
    params.require(:expense_transaction).permit(:description, :amount, :expense_category_id)
  end

  def set_create_form_path
    @form_path = budget_expense_transactions_path
  end

  def set_update_form_path
    @form_path = budget_expense_transaction_path
  end

  def set_expense_categories
    @expense_categories = current_user.expense_categories.where(default: false).order(:name).map do |ec|
      [ec.name, ec.id]
    end
  end
end
