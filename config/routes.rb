Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'

  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#conatct'
  get '/news', to: 'static_pages#news'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  
  get 'store/index'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  #short urls
  get '/short', to: 'short_urls#index'
  get '/short_url', to:'short_urls#show'
  get '/short/short_url', to: 'short_urls#short', as: :shorted
  post '/short_urls/create', to: 'short_urls#create'
  get '/short_urls/fetch_original_url'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
