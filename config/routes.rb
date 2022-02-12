Rails.application.routes.draw do
  root 'home#index'
  post 'patreon/authenticate'
  get 'patreon/user'

  get 'categories', to: 'categories#index'


  namespace :admin do
    get 'albums/index'
    get '/', to: 'admin_dashboards#index'
    post '/', to: 'admin_dashboards#update'

    get 'login', to: 'admin_sessions#new'
    post 'login', to: 'admin_sessions#create'
    post 'logout', to: 'admin_sessions#delete'

    get 'albums', to: 'albums#index'
  end
end
