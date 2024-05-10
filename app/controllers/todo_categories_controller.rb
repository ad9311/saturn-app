class TodoCategoriesController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_category, only: %i[edit update destroy]

  def index
    @table_columns = [
      t('views.todo_categories.table.edit'),
      t('views.todo_categories.table.name'),
      t('views.todo_categories.table.color'),
      t('views.todo_categories.table.delete')
    ]
    @render_path = 'todo_category_table_row'
    rows = @todo_list.todo_categories.where(default: false).order(:name).map do |category|
      { category:, todo_list: @todo_list }
    end
    @rows = Kaminari.paginate_array(rows).page(params[:categories_page])
  end

  def new
    @todo_category = TodoCategory.new
  end

  def edit; end

  def create
    @todo_category = @todo_list.todo_categories.build(todo_category_params)
    if @todo_category.save
      redirect_to todo_list_path(@todo_list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @todo_category.update(todo_category_params)
      redirect_to todo_list_path(@todo_list)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo_category.destroy!

    redirect_to todo_list_path(@todo_list)
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_todo_category
    @todo_category = TodoCategory.find(params[:id])
  end

  def todo_category_params
    params.require(:todo_category).permit(:name, :color)
  end
end
