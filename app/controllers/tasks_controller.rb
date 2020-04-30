class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :destroy, :update]
  
  def index
    # @tasks = Task.all.order(created_at: :desc)
    @tasks = Task.all
    # require 'task'
    
    if params[:sort_expired].present?
    @tasks = @tasks.order(dead_line: :desc)
    else
    @tasks
    end
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('view.create_task')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('view.update_task')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('view.delete_task')
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :dead_line, :condition, 
                                 :priority, :author, :sort_expired)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
