class AddDeletableToExpenseCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :expense_categories, :deletable, :boolean, default: true, null: false
    ExpenseCategory.where(default: true).each {|ec| ec.update(deletable: false) }
  end
end
