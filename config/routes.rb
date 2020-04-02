Rails.application.routes.draw do
  post 'patreon/authenticate'
  get 'patreon/user'
  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
