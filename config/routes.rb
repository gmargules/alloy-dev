Mysize::Application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json }, except: [:new, :edit, :set_new_password] do
      post 'sign_in', to: 'auth#sign_in'
      post 'sign_up', to: 'auth#sign_up'
      post 'sign_out', to: 'auth#sign_out'
      post 'reset_password', to: 'auth#reset_password'
      get 'set_new_password', to: 'auth#set_new_password'
    end
  end
end
