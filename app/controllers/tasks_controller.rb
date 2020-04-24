class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :destroy, :update]
  
  def index
    @tasks = Task.all
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(params[:id])
      redirect_to tasks_path, notice: "タスクを更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :dead_line, :condition, :priority, :author)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
