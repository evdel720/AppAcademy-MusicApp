class SessionsController < ApplicationController
  before_action :require_not_login, only: [:create]
  before_action :require_login, only: [:destroy]


  def create
    user = User.find_by_credentials(user_params[:username], user_params[:password])
    if user && user.activated
      login!(user)
    elsif user && !user.activated
      flash.now[:errors] ||= []
      flash.now[:errors] << "Please check your email and verify your id."
      render :new
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << "User name is invalid or password is wrong."
      render :new
    end
  end

  def destroy
    logout!
  end

end
