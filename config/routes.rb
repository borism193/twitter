Rails.application.routes.draw do

  
  
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:profile, :index, :show, :edit, :create, :update, :destroy] do
    member do
      get :following
      get :followers
    end
  end 
  resources :tweets do
    resources :likes
    member do
      post :retweet
    end
    
  end
  resource  :relationship, only: [:create, :destroy]
  resolve("Relationship") { :relationship }

  
  root "tweets#index"

end
