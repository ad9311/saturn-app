class AddTodoCategoriesToTodoTasks < ActiveRecord::Migration[7.1]
  def change
    change_table :todo_tasks, bulk: true do |t|
      t.references :todo_category, null: false, foreign_key: true
      t.integer :priority, null: false, default: 0
    end
  end
end
