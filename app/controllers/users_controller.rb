class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def edit
  	if @current_user.id != params[:id]
  		return redirect_to :back, alert: 'User does not match'
  end

  def create
  	if User.find_by(username: params[:username])
  		return redirect_to :back, alert: 'Username already exists'
  	if params[:password] != params[:confirm_password]
  		return redirect_to :back, alert: 'Passwords does not match'
  	end
end