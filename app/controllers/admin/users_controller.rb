class Admin::UsersController < ApplicationController
  include SessionsHelper
    before_action :admin_user
    before_action :set_user, only: [:show, :edit, :destroy, :update]

  def new
    @user = User.new
    # @user.admin = false
  end

  def create
    @user = User.new (user_params)
    # binding.irb
     if @user.save
        redirect_to admin_users_path, notice: t('view.create_task')
      else
        render :new
      end
    
  end
  def show
    @tasks = set_user.tasks.order(created_at: :desc)
    # if logged_in?
    #  if current_user.id != @user.id
    #    redirect_to tasks_path
    #  end
    # end
  end
  
  def edit
  end

  def update
    if @user.update(user_params)
     
      redirect_to admin_users_path, notice: t('view.update_task')
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: t('view.delete_user')
  end

  def index
    @users = User.all.order("created_at DESC")
  end

  private
  def admin_user
    unless current_user.admin?
      flash[:notice] = "あなたは管理者ではありません"
      redirect_to tasks_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                        :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
