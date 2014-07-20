class AuthMailer < ActionMailer::Base
  default from: Settings.server_url

  def reset_password(user)
    @creator = user

    mail to: @creator.user.email, subject: "nice! you're a VeedMe creator"
  end
end
