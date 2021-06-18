class Admin::SpecialitiesController < ApplicationController

  def index
    @specialities = Speciality.page(params[:page]).per(10)
    @speciality = Speciality.new
  end

  def edit
    @speciality = Speciality.find(params[:id])
  end

  def create
    @speciality = Speciality.new(speciality_params)
    if @speciality.save
      redirect_to admin_specialities_path, notice: '作成に成功しました．'
    else
      @specialities = Speciality.page(params[:page]).per(10)
      render :index
    end
  end

  def update
    @speciality = Speciality.find(params[:id])
    if @speciality.update(speciality_params)
      redirect_to admin_specialities_path, notice: '更新に成功しました．'
    else
      render :index
    end
  end

  def destroy
    @speciality = Speciality.find(params[:id])
    @speciality.destroy
    redirect_to admin_specialities_path, notice: '削除に成功しました．'
  end

  private

  def speciality_params
    params.require(:speciality).permit(:name)
  end

end
