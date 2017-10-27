class SessionsController < ApplicationController

  before_action :require_logged_in, only: [:destroy]
  before_action :require_logged_out, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password],
    )

    if @user.nil?
      flash.now[:errors] = ["Invalid user_name or password"]
      render :new
    else
      login!(@user)
      redirect_to cats_url
    end
  end

  def destroy
    # logout!
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
      redirect_to new_session_url
    else

    end
  end

end
