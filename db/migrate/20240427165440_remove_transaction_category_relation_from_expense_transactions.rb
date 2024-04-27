class RemoveTransactionCategoryRelationFromExpenseTransactions < ActiveRecord::Migration[7.1]
  def change
    remove_column :expense_transactions, :transaction_category_id
  end
end
