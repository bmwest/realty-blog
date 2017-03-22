Rails.application.routes.draw do
  devise_for :users
  get 'home/index'

  resources :user do
    resources :articles
  end

  resources :articles do
    resources :comments
  end

  resources :comments

  root 'home#index'
end
