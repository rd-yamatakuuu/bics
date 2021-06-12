class Public::IdeasController < ApplicationController

  def new
    @idea = Idea.new
  end

  def index
    @ideas = current_user.ideas
  end
  
  def search
    @ideas = Idea.all
  end
  
  def show
    @idea = Idea.find(params[:id])
    @user = @idea.user
    @tag_list = @idea.tags.pluck(:tag_name).join(',')
    @comment = Comment.new
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
      redirect_to idea_path(@idea)
    else
      render :edit
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to ideas_path
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :content, :icon, :presentation)
  end

end
