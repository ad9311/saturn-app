class AddDefaultValuesToTransactionCategories < ActiveRecord::Migration[7.1]
  def change
    change_column :transaction_categories, :name, :string, null: false
    change_column :transaction_categories, :color, :string, null: false
  end
end
