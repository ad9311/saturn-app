class CreateTodoTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :todo_tasks do |t|
      t.references :todo_list, null: false, foreign_key: true
      t.text :text, null: false
      t.boolean :done, default: false, null: false

      t.timestamps
    end
  end
end
