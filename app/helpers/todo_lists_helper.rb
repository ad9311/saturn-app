module TodoListsHelper
  def bredcrumbs_todo_lists_show(todo_list)
    [
      { body: t('views.todo_lists.breadcrumbs.home'), path: root_path },
      { body: t('views.todo_lists.breadcrumbs.todo_lists'), path: todo_lists_path },
      { body: todo_list.name }
    ]
  end

  def bredcrumbs_todo_lists_new
    [
      { body: t('views.todo_lists.breadcrumbs.home'), path: root_path },
      { body: t('views.todo_lists.breadcrumbs.todo_lists'), path: todo_lists_path },
      { body: t('views.todo_lists.breadcrumbs.new_list') }
    ]
  end

  def todo_list_index_nav_links
    [
      { body: t('views.todo_lists.navigation_links.add'), path: new_todo_list_path }
    ]
  end

  def todo_list_show_nav_links(todo_list)
    [
      { body: t('views.todo_lists.navigation_links.add'), path: new_todo_list_path },
      { body: t('views.todo_lists.navigation_links.edit'), path: edit_todo_list_path(todo_list) }
    ]
  end

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
