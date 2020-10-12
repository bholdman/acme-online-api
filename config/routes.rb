Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, param: :_username

  namespace :v1 do
    post '/auth/login', to: 'authentication#login'
    post '/auth/create', to: 'authentication#create'
    post '/customer/test', to: 'customers#test'
    get '/subscriptions', to: 'subscriptions#index'
    post '/subscriptions/subscribe', to: 'subscriptions#subscribe'
  end

  # Handle any routes that don't exist and return a not found
  get '/*a', to: 'application#not_found'
  post '/*a', to: 'application#not_found'

end
