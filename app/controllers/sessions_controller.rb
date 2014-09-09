class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user && user.password == params[:password]
      cookies.permanent[:token] = user.access_token
      puts 'product'
      puts cookies[:product_id]
      puts 'business'
      puts cookies[:bussiness_id]
      redirect_to :controller => 'web_widgets', :action => 'main', :product_id => (cookies.delete :product_id), :business_id => (cookies.delete :business_id)
    else
      return redirect_to :back, alert: 'Invalid username or password'
    end
  end

  def destroy
    cookies.delete(:token)
    redirect_to :back
  end
end
