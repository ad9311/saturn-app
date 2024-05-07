class RenameTodoTaskTextToDescription < ActiveRecord::Migration[7.1]
  def change
    rename_column :todo_tasks, :text, :description
  end
end
