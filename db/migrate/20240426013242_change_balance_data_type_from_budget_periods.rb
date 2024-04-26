class ChangeBalanceDataTypeFromBudgetPeriods < ActiveRecord::Migration[7.1]
  def change
    change_column :budget_periods, :balance, :decimal, precision: 11, scale: 2
  end
end
