class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(user_params[:username], user_params[:password])
    if user
      login!(user)
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
