class UsersController < ApplicationController
	before_filter :current_user, only: :edit

  def new
  	@user = User.new
  end

  def edit
  	if @current_user.id != params[:id]
  		head(401)
  	end
  end

  def update
  		head(402)
  end

  def create

  	if params[:user][:password] != params[:user][:confirm_password]
  		return redirect_to :back, alert: 'Passwords does not match'
  	end
  	
  	@current_user = User.create(username: params[:user][:username], password: params[:user][:password], first_name: params[:user][:first_name], 
  		last_name: params[:user][:last_name])
  	if(@current_user)
  		cookies.permanent[:token] = @current_user.access_token
		render 'edit'
	else
		render 'new'
	end
  end
end