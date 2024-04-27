class AddIncomeCountAndExpensesCountToBudgetPeriods < ActiveRecord::Migration[7.1]
  def change
    add_column :budget_periods, :income_count, :integer, default: 0, null: false
    add_column :budget_periods, :expense_count, :integer, default: 0, null: false
  end
end
