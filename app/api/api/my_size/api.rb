module MySize
  class API < Grape::API
    version 'v1', using: :path, vendor: 'mysize'

    # HTTP Status Codes
    HTTP_OK = 200
    HTTP_CREATED = 201
    HTTP_BAD_REQUEST = 400
    HTTP_UNAUTHORIZED = 401
    HTTP_NOT_FOUND = 404
    HTTP_METHOD_NOT_ALLOWED = 405
    HTTP_INTERNAL_SERVER_ERROR = 500

    default_error_status HTTP_BAD_REQUEST
    format :json

    helpers do
      def current_user
        @current_user ||= User.active.find_by(access_token: params[:token])
      end

      def restrict_access
        error!('Unauthorized', HTTP_UNAUTHORIZED) unless current_user
      end      
    end

    before do
      # log sent parameters
      puts ({ params: params })
    end

    after_validation do
      # set the default status code for successful requests
      status HTTP_OK      
    end

    mount UsersHandler        

    namespace do
      before do
        header['Access-Control-Allow-Origin'] = '*'
        header['Access-Control-Request-Method'] = '*'
      end

      add_swagger_documentation \
        mount_path: '/docs',
        base_path: '/api',
        api_version: 'v1',
        hide_documentation_path: true
    end
  end
end
