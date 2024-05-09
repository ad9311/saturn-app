class AddPrioritizedToTodoLists < ActiveRecord::Migration[7.1]
  def change
    add_column :todo_lists, :prioritized, :boolean, default: false, null: false
  end
end
