class CreateTransactionCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :transaction_categories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :color

      t.timestamps
    end
  end
end
