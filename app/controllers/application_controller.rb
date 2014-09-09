class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  #before_filter :set_p3p

private
	def current_user
		@current_user ||= User.active.find_by(access_token: cookies[:token]) if cookies[:token]
	end 
	
	def authorize
		redirect_to login_url, alert: "Not authorized" if current_user.nil?
	end	 

	def set_p3p
    	headers['P3P'] = 'CP="ALL DSP COR CURa ADMa DEVa OUR IND COM NAV"'
  	end
end
