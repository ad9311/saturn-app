class TodoTasksController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_task, only: %I[edit update destroy]

  def new
    @todo_task = TodoTask.new
    @todo_category_default = @todo_list.todo_categories.default
    @todo_categories = @todo_list.todo_categories.where(default: false).map do |category|
      [category.name, category.id]
    end
  end

  def edit; end

  def create
    @todo_task = @todo_list.todo_tasks.build(todo_task_params)
    if @todo_task.save
      redirect_to todo_list_path(@todo_list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @todo_task.update(todo_task_params)
      redirect_to todo_list_path(@todo_list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @todo_task.destroy!

    redirect_to todo_list_path(@todo_list)
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_todo_task
    @todo_task = TodoTask.find(params[:id])
  end

  def todo_task_params
    params.require(:todo_task).permit(:description, :todo_category, :priority)
  end
end
