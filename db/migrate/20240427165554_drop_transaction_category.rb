class DropTransactionCategory < ActiveRecord::Migration[7.1]
  def change
    drop_table :transaction_categories
  end
end
