class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :destroy, :update]
  
  def index
    # binding.irb
    # @tasks = Task.all.order(created_at: :desc)
    @tasks = Task.all
    # require 'task'
  #  binding.irb
    if params[:task].present? && params[:task][:sort_expired].present?
    @tasks = @tasks.order(dead_line: :desc)
    else
    @tasks
    end
    # binding.irb
    if params[:task].present? && params[:task][:search].present?
      # binding.irb
      if params[:task][:title].present? && params[:task][:condition].present?
        @tasks = Task.where('title LIKE ?', "%#{params[:task][:title]}%").where(condition: params[:task][:condition])
        # binding.irb
      elsif params[:task][:title].present?
       
        @tasks = Task.where('title LIKE ?', "%#{params[:task][:title]}%")
       
      elsif params[:task][:condition].present?
        @tasks = Task.where(condition: params[:task][:condition])
      end
      # binding.irb
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
