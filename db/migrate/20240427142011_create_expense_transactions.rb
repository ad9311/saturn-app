class CreateExpenseTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :expense_transactions do |t|
      t.references :budget_period, null: false, foreign_key: true
      t.references :transaction_category, null: false, foreign_key: true
      t.string :description
      t.decimal :amount

      t.timestamps
    end
  end
end
