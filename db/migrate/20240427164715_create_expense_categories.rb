class CreateExpenseCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :expense_categories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :color, null: false

      t.timestamps
    end
  end
end
