class UsersController < ApplicationController
  before_action :require_not_login, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      mail = UserMailer.verify_email(@user)
      mail.deliver
      flash[:notice] = "We sent an email for you. Please verify your id."
      redirect_to bands_url
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @user.errors.full_messages
      render :new
    end
  end

  def activate
    @user = User.find_by(activate_token: params[:activate_token])
    if @user.activated
      flash[:notice] = "Your account is already activated."
      redirect_to bands_url
    else
      @user.activate!
      flash[:notice] = "Your account is successfully activated."
      redirect_to new_session_url
    end
  end
end
