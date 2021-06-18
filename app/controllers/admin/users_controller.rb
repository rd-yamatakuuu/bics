class Admin::UsersController < ApplicationController

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: '更新に成功しました．'
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:status, :mentor_check)
  end
end
