class AddDefaultToExpenseCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :expense_categories, :default, :boolean, default: false, null: false
  end
end
