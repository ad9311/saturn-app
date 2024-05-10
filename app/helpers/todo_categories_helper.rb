module TodoCategoriesHelper
  def todo_categories_index_breadcrumbs(todo_list)
    [
      { body: todo_list.name, path: todo_list_path(todo_list) },
      { body: t('views.todo_categories.title') }
    ]
  end

  def todo_categories_new_breadcrumbs(todo_list)
    [
      { body: todo_list.name, path: todo_list_path(todo_list) },
      { body: t('views.todo_categories.title'), path: todo_list_todo_categories_path(todo_list) },
      { body: t('views.todo_categories.navigiation_links.new_category') }
    ]
  end

  def todo_categories_edit_breadcrumbs(todo_list)
    [
      { body: todo_list.name, path: todo_list_path(todo_list) },
      { body: t('views.todo_categories.title'), path: todo_list_todo_categories_path(todo_list) },
      { body: t('views.todo_categories.navigiation_links.edit_category') }
    ]
  end

  def todo_categories_index_navigation_links(todo_list)
    [
      {
        body: t('views.todo_categories.navigation_links.new_category'),
        path: new_todo_list_todo_category_path(todo_list)
      }
    ]
  end
end
