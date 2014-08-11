class UsersHandler < MySize::API
  helpers do
    def valid_fb_token?(fb_id, token, scopes=nil)
      begin
        response = RestClient.get "https://graph.facebook.com/debug_token", {:params => {'input_token' => token, 'access_token' => Settings.fb_access_token}}
        res_hash = JSON.parse(response)

        if (response.code == 200)
          if res_hash["data"]["app_id"] == Settings.fb_app_id && res_hash["data"]["user_id"].to_s == fb_id && res_hash["data"]["is_valid"] == true
            # do we need to check for specific scopes?
            unless scopes.blank?
              scopes.split(/, ?/).each do |s|
                unless res_hash["data"]["scopes"].include?(s)
                  return false
                end
              end
            end
            return true
          end
        end

        return false
      rescue
        return false
      end
    end
  end

  #-----[POST]/login-----
  desc 'Login an existing user or create a new one',
       entity: User::EntityWithToken,
       entity_dependencies: [User::EntityWithToken]
  params do
    requires :username, type: String
    requires :password, type: String
    requires :auth_type, type: Integer, values: [User::AUTH_TYPE_PASSWORD, User::AUTH_TYPE_FACEBOOK]
    optional :first_name, type: String
    optional :last_name, type: String
  end
  post :login do
    if params[:auth_type] == User::AUTH_TYPE_FACEBOOK
      unless valid_fb_token?(params[:username], params[:password])
        error!('Invalid facebook token', HTTP_UNAUTHORIZED)
      end
    end

    # get the user
    @current_user = User.active.find_by(username: params[:username])

    unless @current_user.blank?
      # user exists - validate credentials if needed
      if params[:auth_type] == User::AUTH_TYPE_PASSWORD
        unless @current_user.password == params[:password]
          error!('Invalid username or password', HTTP_UNAUTHORIZED)
        end
      end
    else
      # create a new user
      unless params[:first_name].blank? || params[:last_name].blank?
        if @current_user.blank?
          @current_user = User.new
        end

        @current_user.first_name = params[:first_name]
        @current_user.last_name = params[:last_name]
        @current_user.username = params[:username]
        @current_user.password = params[:password]

        error!('Could not create user', HTTP_INTERNAL_SERVER_ERROR) unless @current_user.save
        status HTTP_CREATED
      else
        error!('Missing first_name or last_name')
      end
    end

    present @current_user, with: User::EntityWithToken
  end

  #-----[POST]/send_reset_password-----
  desc 'Send reset password email'
  params do
    requires :username, type: String
  end
  post :send_reset_password do
    user = User.active.find_by(username: params[:username])
    error!('Invalid email address') if user.blank? || user.auth_type != User::AUTH_TYPE_PASSWORD

    # create a unique password reset token
    begin 
      user.reset_password_token = SecureRandom.hex(21)
      user.reset_password_sent_at = Time.now
    end while User.find_by(reset_password_token: user.reset_password_token)

    error!('Could not issue password reset token', HTTP_INTERNAL_SERVER_ERROR) unless user.save
    AuthMailer.reset_password(user).delive      
  end 

  #-----[POST]/set_new_password-----
  desc 'Set new password'
  params do
    requires :username, type: String
    requires :password, type: String
    requires :reset_password_token, type: String
  end
  post :set_new_password do
    user = User.active.find_by(username: params[:username], reset_password_token: params[:reset_password_token])
    error!('Invalid password reset token', HTTP_UNAUTHORIZED) if user.blank? || user.reset_password_sent_at >= 1.hour.ago
    user.password = params[:password]
    user.reset_password_token = nil
    user.reset_password_sent_at = nil
    error!('Could not set new password', HTTP_INTERNAL_SERVER_ERROR) unless user.save    
  end 

  resource :profile do
    after_validation do
      restrict_access
    end

    #-----[POST]/profile-----
    desc 'Update user data'
    params do
      optional :bust, type: String
      optional :waist, type: String
      optional :thumb
    end
    post do
      @current_user.bust = params[:bust] unless params[:bust].blank?
      @current_user.bust = params[:waist] unless params[:waist].blank?
      @current_user.bust = params[:thumb] unless params[:thumb].blank?
      error!('Could not set new password', HTTP_INTERNAL_SERVER_ERROR) unless @current_user.save    
    end      
  end
end
