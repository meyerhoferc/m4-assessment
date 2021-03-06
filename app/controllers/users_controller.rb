class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Successfully created account for #{user.email}"
      redirect_to root_path
    else
      @user = User.new
      flash[:danger] = determine_message
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def determine_message
    return 'Password and confirmation must match.' unless user_params[:password] == user_params[:password_confirmation]
    return 'You must provide a valid email address for account creation.' if user_params[:email] == ''
  end
end
