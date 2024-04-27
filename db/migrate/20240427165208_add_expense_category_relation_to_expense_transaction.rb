class AddExpenseCategoryRelationToExpenseTransaction < ActiveRecord::Migration[7.1]
  def change
    change_table :expense_transactions do |t|
      t.references :expense_category, null: false, foreign_key: true
    end
  end
end
