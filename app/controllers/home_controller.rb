class HomeController < ApplicationController
  def index
    @budget_period = current_user.budget_periods.order(uid: :desc).first
    @todo_list = current_user.todo_lists.order(updated_at: :desc).first
  end
end
