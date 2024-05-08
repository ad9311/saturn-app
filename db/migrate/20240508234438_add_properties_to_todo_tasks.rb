class AddPropertiesToTodoTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :todo_tasks, :properties, :jsonb, null: false, default: {}
  end
end
