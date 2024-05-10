module TodoListsHelper
  def todo_list_full_tasks_table_rows(todo_list)
    rows = [
      { text: t('views.todo_lists.table.edit') },
      { text: t('views.todo_lists.table.done') },
      { text: t('views.todo_lists.table.task_description') },
      { text: t('views.todo_lists.table.priority'), skip: !todo_list.prioritized },
      { text: t('views.todo_lists.table.category'), skip: !todo_list.categorized },
      { text: t('views.todo_lists.table.date') },
      { text: t('views.todo_lists.table.delete') }
    ]
    rows.map do |row|
      next if !row[:skip].nil? && row[:skip]

      row[:text]
    end.compact
  end
end
