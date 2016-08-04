class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    user.reset_session_token
    session[:session_token] = user.session_token
    redirect_to bands_url
  end

  def logout!
    current_user.reset_session_token
    session[:session_token] = nil
    flash[:notice] = "Successfully logged out. Have a nice day!"
    redirect_to bands_url
  end

  protected
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
