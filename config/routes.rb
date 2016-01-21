Rails.application.routes.draw do

  root to: 'static_pages#home'
  get 'signup',  to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy' 

  resources :users do
    member do
      get 'followers'
      get 'followings'
    end
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts do
    member do
      post 'retweet'
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :followers
  resources :followings

end