class Api::V1::ApiController < ApplicationController
	attr_reader :current_user

	respond_to :json

	before_filter :restrict_access

	protected

		def current_user
			authenticate_with_http_token do |token, options|
				@key = ApiKey.find_by(token: token)
				if @key && !@key.user.is_blocked
    			@current_user = @key.user
    		end
    	end
		end

		def restrict_access
			head :unauthorized if !current_user
		end

		def ok_request
			head 200
		end

		def bad_request
			head 400
		end
		
		def save_error
	    render json: { "response_code"=>"309", "response_text"=>"save error" }
	  end

		def params_error
		  render json: { "response_code"=>"310","response_text"=>"parms error" }
		end

		# a shortcut method for using Rails logger
		def log msg
			Rails.logger.info msg
		end
end
