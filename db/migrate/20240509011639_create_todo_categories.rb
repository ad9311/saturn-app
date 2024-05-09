class CreateTodoCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :todo_categories do |t|
      t.references :todo_list, null: false, foreign_key: true
      t.string :name, null: false
      t.string :color, null: false
      t.boolean :default, null: false, default: false

      t.timestamps
    end
  end
end
