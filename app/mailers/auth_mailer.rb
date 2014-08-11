class AuthMailer < ActionMailer::Base
  default from: "admin@mysize-dev.herokuapp.com"

  def reset_password(user)
    @user = user
    mail to: @user.username, subject: "MySize Password Reset"
  end
end
