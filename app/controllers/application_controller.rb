class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  before_filter :set_cache_buster

private
	def current_user
		@current_user ||= User.active.find_by(access_token: cookies[:token]) if cookies[:token]
	end 
	
	def authorize
		redirect_to login_url, alert: "Not authorized" if current_user.nil?
	end

	def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end




  