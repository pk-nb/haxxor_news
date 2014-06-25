Rails.application.routes.draw do
  root to: 'articles#index'
  resources :articles, only: [:new, :create, :show, :index]
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout
end
