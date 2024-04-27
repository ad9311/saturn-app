class RemoveTransactionCategoryIdFromTransactionIncome < ActiveRecord::Migration[7.1]
  def change
    remove_column :income_transactions, :transaction_category_id
  end
end
