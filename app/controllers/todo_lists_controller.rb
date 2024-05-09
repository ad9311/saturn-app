class TodoListsController < ApplicationController
  before_action :set_todo_list, except: %i[index new]
  def index
    @todo_lists = current_user.todo_lists.order(created_at: :desc)
  end

  def show; end

  def new
    @todo_list = TodoList.new
  end

  def edit; end

  def create
    @todo_list = current_user.todo_lists.build(todo_list_params)
    if @todo_list.save
      redirect_to root_path
    else
      render :new, status: :forbidden
    end
  end

  def update
    if @todo_list.update(todo_list_params)
      redirect_to root_path
    else
      render :new, status: :forbidden
    end
  end

  def destroy
    @todo_list.destroy!

    redirect_to root_path
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(param[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(:name)
  end
end
