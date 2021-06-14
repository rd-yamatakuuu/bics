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

  def profile
    @user = User.find(params[:id])
    @specialities = @user.specialities
  end

  def edit
    @user = User.find(params[:id])
    @specialities = Speciality.all
    @user_speciality = UserSpeciality.new
  end

  def update
    @user = User.find(params[:id])
    @speciality_ids = params[:user][:speciality_ids]
    @speciality_ids.shift
    new_specialities = []
    @speciality_ids.each do |speciality_id|
      speciality = Speciality.find(speciality_id.to_i)
      new_specialities << speciality.name
    end
    if @user.update(user_params)
      @user.speciality_check(new_specialities)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :kana_name, :email, :introduction, :profile_image, :postal_code, :address)
  end
end
