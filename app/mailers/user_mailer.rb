class UserMailer < ApplicationMailer
  default from: 'admin@musicapp.com'

  def verify_email(user)
    @user = user
    #@url = activate_user_url(activate_token: @user.activate_token)
    @url = "localhost:3000/users/activate?activate_token=#{@user.activate_token}"
    mail(to: @user.username, subject: 'Verify user for Music App.')
  end
end
