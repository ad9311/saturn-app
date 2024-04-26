class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :budget_period, null: false, foreign_key: true
      t.references :transaction_category, null: false, foreign_key: true
      t.string :description
      t.float :amount
      t.integer :transaction_type

      t.timestamps
    end
  end
end
