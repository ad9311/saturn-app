class TodoListsController < ApplicationController
  before_action :set_todo_list, except: %i[index new create]
  def index
    @todo_lists = current_user.todo_lists.order(created_at: :desc)
  end

  def show
    rows = @todo_list.todo_tasks.order(done: :desc, created_at: :desc).map do |task|
      { task:, todo_list: @todo_list }
    end
    @render_path = 'todo_lists/task_table_row'
    @rows = Kaminari.paginate_array(rows).page(params[:todo_lists_page])
  end

  def new
    @todo_list = TodoList.new
  end

  def edit; end

  def create
    @todo_list = current_user.todo_lists.build(todo_list_params)
    if @todo_list.save
      redirect_to todo_list_path(@todo_list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @todo_list.update(todo_list_params)
      redirect_to todo_list_path(@todo_list)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo_list.destroy!

    redirect_to todo_lists_path
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(:name, :categorized, :prioritized)
  end
end
