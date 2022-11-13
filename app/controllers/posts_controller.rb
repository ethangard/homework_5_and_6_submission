class PostsController < ApplicationController

  before_action :find_post, only:[:show, :destroy, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user!, only:[:edit, :update, :destroy]


  def something
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    
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
  def find_post 
    @post = Post.find params[:id]
    if @post
    else
      render "Unable to find a post with that ID, please try again."
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authenticate_user!
    redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
  end
  
end
