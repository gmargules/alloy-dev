class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def edit
  	if @current_user.id != params[:id]
  		return redirect_to :back, alert: 'User does not match'
  	end
  end

  def create
  	if User.find_by(username: params[:user][:username])
  		return redirect_to :back, alert: 'Username already exists'
  	end
  	if params[:user][:password] != params[:user][:confirm_password]
  		return redirect_to :back, alert: 'Passwords does not match'
  	end
  	if params[:user][:first_name].blank
  		return redirect_to :back, alert: 'First name is missing'
  	end
  	if params[:user][:last_name].blank
  		return redirect_to :back, alert: 'Last name is missing'
  	end
  end
end