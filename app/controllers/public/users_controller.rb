class Public::UsersController < ApplicationController

  def index
    @ideas = current_user.ideas
    @user = current_user
  end
  
  def user_info
    @user = User.find(params[:id])
    @ideas = @user.ideas.page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
    @specialities = @user.specialities
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
    params.require(:user).permit(:name, :kana_name, :introduction, :profile_image, :postal_code, :address)
  end
end
