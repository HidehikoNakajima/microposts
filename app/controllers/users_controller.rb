class UsersController < ApplicationController
  
  before_action :set_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page]).per(10).order(created_at: :desc)
  end  
    
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = 'ユーザ情報を更新しました'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def followings
    @user = User.find(params[:id])
    @following_users = @user.following_users.page(params[:page]).per(10)
  end
  
  def followers
    @user = User.find(params[:id])
    @follower_users = @user.follower_users.page(params[:page]).per(10)
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :area, :age)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:danger] = '不正なアクセスです'
      redirect_to root_path
    end
  end
  
  
end