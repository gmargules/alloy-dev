Mysize::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1, defaults: { format: :json }, except: [:new, :edit] do
      namespace :auth do
        post 'sign_in'
        post 'sign_up'
        post 'sign_out'
        post 'reset_password'
        get 'get_new_password', defaults: { format: :html }
        post 'set_new_password', defaults: { format: :html }
      end 

      resource :user, only: [:update] do
      
      end

      namespace :size do
        get 'query'
      end
    end
  end
end
