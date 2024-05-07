class TodoListsController < ApplicationController
  def index
    @todo_lists = current_user.todo_lists.order(created_at: :desc)
  end
end
