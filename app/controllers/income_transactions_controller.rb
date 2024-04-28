class IncomeTransactionsController < ApplicationController
  before_action :set_budget_period
  before_action :set_income, only: %i[edit update]
  before_action :set_create_form_path, only: %i[new create]
  before_action :set_update_form_path, only: %i[edit update]

  def new
    @income = IncomeTransaction.new
  end

  def edit; end

  def create
    @income = @budget_period.income_transactions.build(income_params)
    if @income.save
      redirect_to budget_period_details_path(@budget_period.uid)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @income.update(income_params)
      redirect_to budget_period_details_path(@budget_period.uid)
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

  def set_create_form_path
    @form_path = budget_income_transactions_path
  end

  def set_update_form_path
    @form_path = budget_income_transaction_path
  end
end
