class UsersController < ApplicationController
	before_filter :current_user, only: [:edit, :update]

  def new
  	@user = User.new
  end

  def edit
  	if @current_user.id != params[:id]
  		head(401)
  	end
  end

  def update
  		@current_user.update_attributes(height: params[:user][:height], waist: params[:user][:waist], bust: params[:user][:bust])
      #redirect_to main_web_widget_path  #with product and store
  end

  def create
  	if params[:user][:password] != params[:user][:confirm_password]
  		return redirect_to :back, alert: 'Passwords does not match'
  	end
  	
  	@user = User.new(username: params[:user][:username], password: params[:user][:password], first_name: params[:user][:first_name], 
  		last_name: params[:user][:last_name])
  	if(@user.save)
  		@current_user = @user
      cookies.permanent[:token] = @current_user.access_token
		  render 'edit'
	  else
		  render 'new'
    end
  end
end