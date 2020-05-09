class Admin::UsersController < ApplicationController
    before_action :admin_user
    before_action :set_user, only: [:edit, :destroy, :update]

  def new
    @user = User.new
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
    redirect_to admin_users_path, notice: t('view.delete_task')
  end

  def index
    @users = User.all.order("created_at DESC")
  end

  private
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                        :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
