class SessionsController < ApplicationController
  def new
    session[:return_to] = params[:return_to] if params[:return_to]
  end

  def create
    user = User.find_by(username: params[:email])
    if user && user.password == params[:password]
      session[:token] = user.access_token
      cookies.signed[:secure_token] = {secure: true, value: "secure#{user.token}"}
      redirect_to(session.delete(:return_to) || root_url)
    else
      flash.now.alert = "Invalid username or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete(:secure_user_id)
    redirect_to login_url
  end
end
