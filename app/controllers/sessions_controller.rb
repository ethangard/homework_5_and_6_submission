class SessionsController < ApplicationController
  def create
    @user = User.find_by_email params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, { notice: "Logged In" }
    else
      redirect_to new_session_path, { notice: "Wrong email or password", status: 303 }
    end
  end

  def new
  end

  def edit
    @user = current_user
  end


  def update
    # puts current_user
    @user = current_user
    # puts @user
    if @user.update_attributes(params[:current_user])
      # Handle a successful update.
    else
      render 'edit'
    end
  end
  

  def destroy
    session[:user_id] = nil
    flash.notice = "Logged Out"
    redirect_to root_path
  end


  private
    def user_params
      params.require(:user).permit(:name, :email)
    end


end
