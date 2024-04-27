class BudgetPeriodsController < ApplicationController
  before_action :set_budget_period, only: %i[show]

  def index
    @budget_periods = current_user.budget_periods.order(uid: :desc)
  end

  def show; end

  private

  def set_budget_period
    @budget_period = BudgetPeriod.find_by(uid: params[:uid])
  end
end
