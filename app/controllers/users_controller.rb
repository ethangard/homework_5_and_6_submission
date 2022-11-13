class UsersController < ApplicationController

  # before_action :user_params
  # for the password update

  before_action :require_user_logged_in!, only: [:password_update]

  def new
    @user = User.new
  end

  def create
    @user = User.new params.require(:user).permit(
    :name,
    :email,
    :password,
    :password_confirmation
    )

    if @user.save
      session[:user_id] = @user.id
      flash.notice = "Signed Up!"
      redirect_to root_path
    else
      render :new, status: 303
    end
  end


  def edit
    @user = current_user
  end


  def update
    @user = current_user
    if @user.update(user_params)
      flash[:alert] = "User details changed successfully!"
      puts "lollypop"
      # Handle a successful update.
      redirect_to edit_users_path
    else
      flash[:alert] = "Something went wrong, please try again later" 
      render 'edit'
    end
  end


  def password_update
    # puts "cake!!"
    # @user = current_user

    # puts "matches"
    # puts previous_password_matches(password_params[:new_password])

    # puts "Current User Password"
    # puts @user.authenticate(password_params[:new_password])
    # puts current_user.name
    # puts @user.authenticate(params[:password])

    # puts "New Password"
    # puts password_params[:new_password]

    # puts "New Password Confirmation"
    # puts password_params[:new_password_confirmation]


    if current_user.present?  # && current_user.authenticate(password: password_params[:current_password])

      if current_user.password != password_params[:current_password] && password_params[:new_password] == password_params[:new_password_confirmation]
        current_user.update(password: password_params[:new_password])
        flash[:alert] = "Password changed successfully!"
          redirect_to users_password_path
      else
        flash[:alert] = "The Current Password you entered was incorrect, or your new passwords don't match.  Try again."
        redirect_to users_password_path
      end
    end

  
    # if @user.update(password_params)
    # end   

    #puts "This happens before"
    
    # @user = User.find_by_email params[:email]
    # current_user.authenticate(:current_password)
    # puts current_user.authenticate(:current_password)
    #puts current_user
    # current_user.update(password_digest: "911")
    # puts "This happens after"
    # current_user.update(:password_confirmation)



    # puts @user
    # puts @user.password_digest

    # puts "test time"
    # @user.update(user_params)

    #  test = password_params
    #  puts test

    # if @user.update(password_params)
    #   # puts "new stuff"
    #   # puts "current password"
    #   # puts @user.password
    #   # puts "new password"
    #   # puts @user.new_password
    #   # puts "new password confirmation"
    #   # puts @user.new_password_confirmation

    #   redirect_to root_path, notice: "Password updated!"
    # else
    #   render :password_update
    # end

  end

  def password_show
    @user = current_user
  end

  private

    # def find_user
    #   @user = current_user
    # end

     def user_params
       params.require(:user).permit(:name, :email)
     end


     def password_params
      params.require(:user).permit(:current_password,:new_password, :new_password_confirmation)
      # params.require(:user).permit(:name, :email, :password, :current_password, :new_password, :new_password_confirmation)
     end

    #  def previous_password_matches(unencrypted_password)
    #   BCrypt::Password.new(password_digest_was).is_password?(unencrypted_password)
    #  end

end