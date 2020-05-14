class UsersController < ApplicationController
  def new
    @user = User.new
    if logged_in?
      redirect_to user_path(current_user)
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = current_user.tasks.order(created_at: :desc)
    if logged_in?
     if current_user.id != @user.id
       redirect_to tasks_path
     end
    end
  end
      
  private
    
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation)
  end
end
