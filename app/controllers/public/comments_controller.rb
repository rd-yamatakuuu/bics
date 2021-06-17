class Public::CommentsController < ApplicationController

  def create
    idea = Idea.find(params[:idea_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.idea_id = idea.id
    comment.save
    redirect_to idea_path(idea)
  end

  def destroy
    #@idea = Idea.find(params[:id])
    comment = Comment.find_by(id: params[:id], idea_id: params[:idea_id])
    comment.destroy
    redirect_to idea_path(params[:idea_id])
  end
  
  def index
    @user = current_user
    @comments = current_user.comments.order('created_at DESC').page(params[:page]).per(15)
  end


  private

  def comment_params
    params.require(:comment).permit(:comment, :review)
  end
end
