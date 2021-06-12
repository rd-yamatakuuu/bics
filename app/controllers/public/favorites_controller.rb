class Public::FavoritesController < ApplicationController

  def create
    @idea = Idea.find(params[:idea_id])
    @favorite = Favorite.new(idea_id: @idea.id)
    @favorite.user_id = current_user.id
    @favorite.save
    redirect_to idea_path(@idea)
  end

  def destroy
    @idea = Idea.find(params[:idea_id])
    @favorite = Favorite.find_by(idea_id: @idea.id)
    @favorite.user_id = current_user.id
    @favorite.destroy
    redirect_to idea_path(@idea)
  end
  
  def index
    @favorites = current_user.favorites
  end
  
end
