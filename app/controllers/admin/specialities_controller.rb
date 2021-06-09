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
      redirect_to admin_specialities_path
    else
      render :index
    end
  end

  def update
    @speciality = Speciality.find(params[:id])
    if @speciality.update(speciality_params)
      redirect_to admin_specialities_path
    else
      render :index
    end
  end

  def destroy
    @speciality = Speciality.find(params[:id])
    @speciality.destroy
    redirect_to admin_specialities_path
  end

  private

  def speciality_params
    params.require(:speciality).permit(:name)
  end

end
