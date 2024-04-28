class ExpenseTransactionsController < ApplicationController
  before_action :set_budget_period
  before_action :set_expense, only: %i[edit update]
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
      redirect_to budget_period_path(@budget_period.uid)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @expense.update(expense_params)
      redirect_to budget_period_path(@budget_period.uid)
    else
      render :edit, status: :unprocessable_entity
    end
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
    @expense_categories = current_user.expense_categories.map { |ec| [ec.name, ec.id] }
  end
end
