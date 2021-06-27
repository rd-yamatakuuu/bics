class Public::UsersController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :ensure_corrent_user, only: [:show, :edit, :update, :unsubscribe, :withdraw]

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
      redirect_to user_path(@user), notice: '情報の更新に成功しました．'
    else
      render :edit
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(status: true)
    reset_session
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :kana_name, :email, :introduction, :profile_image, :postal_code, :address)
  end

  def ensure_corrent_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_info_user_path(@user)
    end
  end

end
