class UsersController < ApplicationController
  
  before_action :set_user, only: [:edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]
  
  def show
    @user = User.find(params[:id])
  end  
    
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:save] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update(user_params)
      redirect_to root_path , notice: 'ユーザ情報を更新しました'
    else
      render 'edit'
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
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