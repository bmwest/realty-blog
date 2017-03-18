Rails.application.routes.draw do
  devise_for :users
  get 'home/index'

  resources :user do
    resources :articles
  end

  resources :admin
  resources :articles

  root 'home#index'
end
