Mysize::Application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json }, except: [:new, :edit] do
      post 'sign_in', to: 'auth#sign_in'
      post 'sign_up', to: 'auth#sign_up'
      post 'sign_out', to: 'auth#sign_out'
    end
  end
end
