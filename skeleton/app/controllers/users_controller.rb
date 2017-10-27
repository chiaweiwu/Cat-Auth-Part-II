class UsersController < ApplicationController


  before_action :require_logged_out

  def new

    @user = User.new
    render :new
  end

  def create
    @user = User.new(params_users)
    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @users.errors.full_messages
      render :new
    end
  end

  def params_users
    params.require(:user).permit(:user_name, :password)
  end
end
