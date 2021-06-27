class Public::IdeasController < ApplicationController

  before_action :authenticate_user!, only: [:new, :show, :edit, :create, :update, :destroy]
  before_action :ensure_corrent_user, only: [:edit, :update]

  def new
    @idea = Idea.new
  end

  def index
  end

  def search
    @ideas = Idea.order('created_at DESC').page(params[:page]).per(8)
    @ideas_rank = Tag.find(IdeaTag.group(:tag_id).order(Arel.sql('count(idea_id) desc')).limit(3).pluck(:tag_id))
  end

  def rank_fav
    @ideas = Idea.find(Favorite.group(:idea_id).order(Arel.sql('count(idea_id) desc')).limit(5).pluck(:idea_id))
  end

  def rank_com
    @ideas = Idea.find(Comment.group(:idea_id).order(Arel.sql('count(user_id) desc')).limit(5).pluck(:idea_id))
  end

  def rank_rev
    @ideas = Idea.find(Comment.group(:idea_id).order(Arel.sql('AVG(review) desc')).limit(5).pluck(:idea_id))
  end

  def show
    @idea = Idea.find(params[:id])
    @user = @idea.user
    @tag_list = @idea.tags.pluck(:tag_name).join(',')
    @comment = Comment.new
    @comments = @idea.comments
  end

  def edit
    @idea = Idea.find(params[:id])
    @tag_list = @idea.tags.pluck(:tag_name).join(',')
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id
    tag_list = params[:idea][:tag_ids].split(',')
    if @idea.save
      @idea.save_tags(tag_list)
      redirect_to congratulations_path
    else
      render :new
    end
  end

  def update
    @idea = Idea.find(params[:id])
    tag_list = params[:idea][:tag_ids].split(',')
    if @idea.update(idea_params)
      @idea.save_tags(tag_list)
      redirect_to edit_idea_path(@idea), notice: '更新に成功しました．'
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to user_info_user_path(@user), notice: '削除に成功しました．'
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :content, :icon, :presentation)
  end

  def ensure_corrent_user
    @idea = Idea.find(params[:id])
    unless @idea.user == current_user
      redirect_to search_path
    end
  end

end
