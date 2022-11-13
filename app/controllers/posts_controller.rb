class PostsController < ApplicationController

  before_action :find_post, only:[:show, :destroy, :edit, :update]


  def something
  end

  def new
    @post = Post.new
  end

  def create
    # Miniumum of 50 chracters are needed to create a post 
    @post = Post.new(post_params)
    # puts @post.title
    # puts @post.body
    if @post.save
      flash[:success] = "Post successfully saved"
      redirect_to @post
    else
      flash[:error] = "Something went wrong, please check to see if your post body has a unique title and is at least 50 characters in length"
      render :new, {alert: "Something went wrong, please check to see if your post body has a unique title and is at least 50 characters in length", status: 303}
    end
  end

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    # @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
    @comment = Comment.new
    if @post

    else
       flash[:error] = "Unable to find a post with that ID, please try again."
    end
  end



  def edit

  end

 

  def update
    if @post.update(post_params)
      flash[:success] = "Post successfully updated"
      redirect_to @post
      else        
        flash[:error] = "Something went wrong"
        flash[:notice] = "Something went wrong"
        render :edit
      end
  end

  def destroy
    if @post
      @post.destroy
      flash[:notice] = "Post successfully deleted."
      redirect_to posts_path
    else
       flash[:error] = "Unable to find a post with that ID, try again."
    end
  end


  # Private Methods

  private

  def find_post 
    @post = Post.find params[:id]
    flash[:notice] = "Post not found" unless @post
    if @post
      # post is brought to the relevant method
    else
      render "Unable to find a post with that ID, please try again."
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
  
end
