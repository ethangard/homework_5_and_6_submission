class CommentsController < ApplicationController

  before_action :find_post

  def create
    @comment = Comment.new(comment_params)
    puts "calculator"
    puts @comment.comment
    @comment.post = @post
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
    puts "watermelon"
    puts @comment
    flash[:success] = "Comment successfully deleted."

    @comment.destroy
    redirect_to post_path(@comment.post)
  end


  private
  
  def find_post
    @post = Post.find params[:post_id]
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
