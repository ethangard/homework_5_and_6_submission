class CommentsController < ApplicationController

  before_action :find_post
  before_action :authenticate_user!
  # before_action :authorize_user!, only: [:destroy]

  def create
    @comment = Comment.new(comment_params)
    # puts "calculator"
    # puts @comment.comment
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment successfully Created!"
      redirect_to @post
    else
      @comments = @post.comments.order(created_at: :desc)
      render 'posts/show', status: 303
    end
  end


  def destroy
    @comment = Comment.find params[:id]
    # puts "watermelon"
    # puts @comment
    
    if can?(:crud, @comment)
      @comment.destroy
      flash[:success] = "Comment successfully deleted."
      redirect_to post_path(@comment.post)
    else
        redirect_to root_path, alert: "Not authorized to delete comment!"
    end
  end


  private
  
  def find_post
    @post = Post.find params[:post_id]
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def authorize_user!
    redirect_to root_path, alert: "Not authorized!" unless can?(:crud, @comment)
  end
  
end
