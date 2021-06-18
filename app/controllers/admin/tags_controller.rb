class Admin::TagsController < ApplicationController

  def index
    @tags = Tag.page(params[:page]).per(15)
    @tag = Tag.new
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, notice: '作成に成功しました．'
    else
      @tags = Tag.page(params[:page]).per(15)
      render :index
    end
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admin_tags_path, notice: '更新に成功しました．'
    else
      render :index
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to admin_tags_path, notice: '削除に成功しました．'
  end

  private

  def tag_params
    params.require(:tag).permit(:tag_name)
  end

end
