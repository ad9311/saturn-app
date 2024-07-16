class RenameBudgetPeriods < ActiveRecord::Migration[7.1]
  def change
    rename_table :budget_periods, :budgets
  end
end
