Mysize::Application.routes.draw do
  # active admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # api server
  mount MySize::API => '/api'
  
  # web widget
  get :signup, to: 'users#new'
  get :login, to: 'sessions#new'
  get :logout, to: 'sessions#destroy'

  resource :web_widget do
  	get :main
  end
end
