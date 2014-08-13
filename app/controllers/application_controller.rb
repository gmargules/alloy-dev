class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :default_headers

private
	def current_user
		@current_user ||= User.active.find_by(access_token: cookies[:token]) if cookies[:token]
	end 
	
	def authorize
		redirect_to login_url, alert: "Not authorized" if current_user.nil?
	end	

	def default_headers
		headers['X-Frame-Options'] = 'ALLOWALL'
	end	 
end
