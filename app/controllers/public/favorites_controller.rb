class Public::FavoritesController < ApplicationController
  
  before_action :authenticate_user!

  def create
    @idea = Idea.find(params[:idea_id])
    @favorite = Favorite.new(idea_id: @idea.id)
    @favorite.user_id = current_user.id
    @favorite.save
    
    @idea.create_notification_by(current_user)
  
  end

  def destroy
    @idea = Idea.find(params[:idea_id])
    @favorite = Favorite.find_by(idea_id: @idea.id)
    @favorite.user_id = current_user.id
    @favorite.destroy
  end
  
  def index
    @user = current_user
    @favorites = @user.favorites
  end
  
  
end
