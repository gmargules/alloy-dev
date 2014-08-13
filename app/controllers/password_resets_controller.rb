class PasswordResetsController < ApplicationController
  def new
  end

  def create
    puts "!!!!!!!!!!!!!!!"
    puts params[:email]

    user = User.active.find_by(username: params[:email])
    return redirect_to :back, alert: 'Invalid email address.' if user.blank? || user.auth_type != User::AUTH_TYPE_PASSWORD

    # create a unique password reset token
    begin 
      user.reset_password_token = SecureRandom.hex(21)
      user.reset_password_sent_at = Time.now
    end while User.find_by(reset_password_token: user.reset_password_token)

    return redirect_to :back, alert: 'Could not create password reset token, please try again later.' unless user.save
    AuthMailer.reset_password(user).deliver 
  end
  
  def edit
    @user = User.active.find_by(username: params[:email], reset_password_token: params[:token])
  end
  
  def update
    user = User.active.find_by(username: params[:user][:email], reset_password_token: params[:user][:token])
    return redirect_to reset_password_path, alert: 'Invalid password reset token. Please try again.' if user.blank? || user.reset_password_sent_at < 1.hour.ago
    return redirect_to :back, alert: 'Could not set new password, please try again later.' unless user.update_attributes(password: params[:user][:password], reset_password_token: nil, reset_password_sent_at: nil)
  end  
end
