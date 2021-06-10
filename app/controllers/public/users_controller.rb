class Public::UsersController < ApplicationController

  def index
    @ideas = current_user.ideas
    @user = current_user
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
      redirect_to user_path(@user)
    else 
      render :edit
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :kana_name, :profile_image, :postal_code, :address)
  end
end
