class CreateIncomeTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :income_transactions do |t|
      t.references :budget_period, null: false, foreign_key: true
      t.references :transaction_category, null: false, foreign_key: true
      t.string :description, null: false
      t.decimal :amount, precision: 11, scale: 2, null: false

      t.timestamps
    end
  end
end
