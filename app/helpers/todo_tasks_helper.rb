module TodoTasksHelper
  def bredcrumbs_todo_task_new(todo_list)
    [
      { body: t('views.todo_tasks.forms.todo_lists'), path: todo_lists_path },
      { body: todo_list.name, path: todo_list_path(todo_list) },
      { body: t('views.todo_tasks.forms.new_todo_task') }
    ]
  end
end
