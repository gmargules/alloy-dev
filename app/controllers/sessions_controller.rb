class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user && user.password == params[:password]
      cookies.permanent[:token] = user.access_token
      puts 'product'
      puts cookies[:product_id]
      puts 'business'
      puts cookies[:bussiness_id]
      redirect_to user_successful_login_path(user.id)
    else
      return redirect_to :back, alert: 'Invalid username or password'
    end
  end

  def destroy
    cookies.delete(:token)
    redirect_to :back
  end
end
