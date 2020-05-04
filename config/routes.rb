Rails.application.routes.draw do
  root 'home#index'
  post 'patreon/authenticate'
  get 'patreon/user'

  resources :categories
  get 'login', to: 'admin_sessions#new'
  post 'login', to: 'admin_sessions#create'
end
