class UsersController < ApplicationController
	before_filter :current_user, only: [:edit, :update]

  def new
  	@user = User.new
  end

  def edit
  	if @current_user.id != params[:id].to_i
  		head(401)
    else
      @user = @current_user
  	end
  end

  def update
      @user = User.find_by(id: params[:id]);
    		
      if @user.update_attributes(height: params[:user][:height], waist: params[:user][:waist], bust: params[:user][:bust])
        redirect_to :controller => 'web_widgets', :action => 'main', :product_id => (cookies.delete :product_id), :business_id => (cookies.delete :business_id)
      else
        puts 'AAAAAAABGF'
        puts @user.errors.full_messages
        return redirect_to edit_user_path(@user), alert: @user.errors.full_messages.first
      end
  end

  def create	
  	@user = User.new(username: params[:user][:username].downcase, password: params[:user][:password].downcase, first_name: params[:user][:first_name], 
  		last_name: params[:user][:last_name])
  	if(@user.save)
      cookies.permanent[:token] = @user.access_token
		  render 'edit'
	  else
		  render 'new'
    end
  end

  def login
  end

  def successful_login
  end
end