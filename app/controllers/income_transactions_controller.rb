class IncomeTransactionsController < ApplicationController
  before_action :set_budget_period
  before_action :set_income, only: %i[edit update]

  def new
    @income = IncomeTransaction.new
    @form_path = budget_income_transactions_path
  end

  def edit
    @form_path = budget_income_transaction_path
  end

  def create
    @form_path = budget_income_transactions_path
    @income = @budget_period.income_transactions.build(income_params)
    if @income.save
      redirect_to budgets_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @form_path = budget_income_transaction_path
    if @income.update(income_params)
      redirect_to budgets_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_budget_period
    @budget_period = BudgetPeriod.find_by(uid: params[:budget_uid])
  end

  def set_income
    @income = IncomeTransaction.find(params[:id])
  end

  def income_params
    params.require(:income_transaction).permit(:description, :amount)
  end
end
