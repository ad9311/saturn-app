class AddTransactionsCountToBudgetPeriods < ActiveRecord::Migration[7.1]
  def change
    add_column :budget_periods, :transaction_count, :integer, default: 0, null: false
  end
end
