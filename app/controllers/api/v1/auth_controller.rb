class Api::V1::AuthController < Api::V1::ApiController
  skip_before_filter :restrict_access, :except => [:sign_out]
  
	def sign_in    
		if (!params[:email].blank? && !params[:password].blank?)
			@user = User.find_by(email: params[:email])
			if (@user && @user.password == params[:password])
				if (!@user.is_blocked)
					# check for valid token (= active session)
					@token = @user.api_keys.active.order(created_at: :desc).first
					if @token.blank? 
						# no token found. create a new one.
						@key = @user.api_keys.create!
						
						# update user attributes
						@user.sign_in_count += 1
						@user.current_sign_in_at = Time.now
						if @user.save
							render 'api/v1/users/show'
						else
							save_error
						end
					else
						render json: { "response_code"=>"200", "response_text"=>"user already signed in" }
					end
				else
					render json: { "response_code"=>"311", "response_text"=>"user is blocked" }
				end
			else
				render json: { "response_code"=>"312", "response_text"=>"invalid user name or password" }
			end
		else
			params_error
		end
	end

	def sign_up
		# check for required params    
		unless params[:email].blank? || params[:password].blank? || params[:first_name].blank? || params[:last_name].blank?
			@user = User.find_by(email: params[:email])

			unless @user
				@user = User.new
				@user.email = params[:email]
				@user.password = params[:password]
				@user.first_name = params[:first_name]
				@user.last_name = params[:last_name]
				@user.sign_in_count += 1
				@user.current_sign_in_at = Time.now

			  if @user.save
					# create a unique token
				  @key = @user.api_keys.create!
			  	render 'api/v1/users/show'
			  else
			  	save_error
			  end
		  else
		  	render json:{ "response_code"=>"313", "response_text"=>"email already taken" }
		  end
		else
			params_error
		end
	end

	def sign_out
		# invalidate current access token and create a new one
		@key.expires_at = Time.now
		if @key.save
			@current_user.last_sign_in_at = @current_user.current_sign_in_at
			@current_user.current_sign_in_at = nil
			if @current_user.save
				render json: { "response_code"=>"200", "response_text"=>"successfully signed out" }
			else
				save_error
			end
		else
			save_error
		end
	end

	def reset_password
		unless params[:email].blank?
			user = User.find_by(email: params[:email])

			# create a unique password reset token
      begin 
      	user.reset_password_token = SecureRandom.hex(16)
      	user.reset_password_sent_at = Time.now
      end while User.find_by(reset_password_token: user.reset_password_token)

     	if user.save
     		AuthMailer.reset_password(user)
     		render json: { "response_code"=>"200", "response_text"=>"reset password email sent" }
     	else
     		save_error
     	end
		end
	end

	def set_new_password
		unless params[:email].blank? || params[:token].blank?
			user = User.find_by(email: params[:email], reset_password_token: params[:token])

			@valid = user && user.reset_password_sent_at < Time.now - 1.minute
		else
			@valid = true
		end

		render 'auth/set_password'
	end
end
