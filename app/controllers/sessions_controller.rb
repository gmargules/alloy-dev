class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user && user.password == params[:password]
      cookies.permanent[:token] = user.access_token
      redirect_to :back
    else
      return redirect_to :back, alert: 'Invalid username or password'
    end
  end

  def destroy
    cookies.delete(:token)
    redirect_to :back
  end
end
