class AddDefaultValuesToBudgetPeriods < ActiveRecord::Migration[7.1]
  def change
    change_column :budget_periods, :balance, :float, default: 0.0, null: false
    change_column :budget_periods, :month, :integer, null: false
    change_column :budget_periods, :year, :integer, null: false
    change_column :budget_periods, :year_month, :integer, null: false
  end
end
