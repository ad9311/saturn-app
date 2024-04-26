class AddDefaultValuesToTransactions < ActiveRecord::Migration[7.1]
  def change
    change_column :transactions, :description, :string, null: false
    change_column :transactions, :amount, :float, null: false
    change_column :transactions, :transaction_type, :integer, null: false
  end
end
