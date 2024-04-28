class IncomeTransactionsController < ApplicationController
  before_action :set_budget_period
  before_action :set_income, only: %i[edit update]

  def new
    @income = IncomeTransaction.new
    @form_url = budget_income_path
  end

  def edit
    @form_url = "/budgets/#{@budget_period.uid}/income/#{@income.id}"
  end

  def create
    @income = @budget_period.income_transactions.build(income_params)
    if @income.save
      redirect_to budgets_path
    else
      render :new
    end
  end

  def update
    if @income.update(income_params)
      redirect_to budgets_path
    else
      render :edit
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
