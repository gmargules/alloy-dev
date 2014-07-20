class AuthMailer < ActionMailer::Base
  default from: "admin@mysize-dev.herokuapp.com"

  def reset_password(user)
    @user = user
    mail to: @user.email, subject: "MySize Password Reset"
  end
end
