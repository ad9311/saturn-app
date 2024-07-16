class RenameTransactionRelationsToBudgets < ActiveRecord::Migration[7.1]
  def change
    rename_column :expense_transactions, :budget_period_id, :budget_id
    rename_column :income_transactions, :budget_period_id, :budget_id
  end
end
