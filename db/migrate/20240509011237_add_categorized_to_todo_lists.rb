class AddCategorizedToTodoLists < ActiveRecord::Migration[7.1]
  def change
    add_column :todo_lists, :categorized, :boolean, null: false, default: false
  end
end
