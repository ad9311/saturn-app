class BudgetPeriodsController < ApplicationController
  def index
    @budget_periods = current_user.budget_periods
  end

  def show; end
end
