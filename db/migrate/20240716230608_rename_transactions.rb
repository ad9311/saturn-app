class RenameTransactions < ActiveRecord::Migration[7.1]
  def change
    rename_table :income_transactions, :incomes
    rename_table :expense_transactions, :expenses
  end
end
