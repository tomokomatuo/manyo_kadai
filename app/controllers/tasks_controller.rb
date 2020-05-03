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
   
    if params[:task][:search].present?
     
      if params[:task][:title].present? && params[:task][:condition].present?
        @tasks = Task.where('title LIKE ?', "%#{params[:task][:title]}%").joins(condition: params[:task][:condition])
      elsif params[:task][:title].present?
        @tasks = Task.where('title LIKE ?', "%#{params[:task][:title]}%")
      elsif params[:task][:condition].present?
        @tasks = Task.where(condition: params[:task][:condition])
      end
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
                                 :priority, :author, :sort_expired, :search)
  end

  def set_task
    @task = Task.find(params[:id])
  end
  def search
    # if params[:search].present?
    #   if params[:search] == params[:title] && params[:condition]
    #   elsif params[:search] == params[:title]
    #     @tasks = Task.where('title LIKE ?', "%#{params[:title]}%")
    #   elsif params[:search] == params[:condition]
    #     @tasks = Task.where(condition: params[:condition])
    #   end
    # end
  end
end
