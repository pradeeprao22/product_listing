Rails.application.routes.draw do
  
  root 'static_pages#home'

  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  
  get 'store/index'

  resources :users
  resources :products

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
