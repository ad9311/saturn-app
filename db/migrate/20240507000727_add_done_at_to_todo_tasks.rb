class AddDoneAtToTodoTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :todo_tasks, :done_at, :timestamp
  end
end
