class HomeController < ApplicationController
  def index
    @budget_period = current_user.budget_periods.order(uid: :desc).first
  end
end
