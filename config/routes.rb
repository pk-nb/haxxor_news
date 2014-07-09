Rails.application.routes.draw do
  root to: 'articles#index'
  resources :articles, only: [:new, :create, :show, :index] do
    resources :comments, only: [:create]
  end

  resources :comments, only: [] do
    resources :comments, only: [:create]
  end

  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update], path: 'reset', as: :reset

  get 'signup', to: 'users#new', as: :signup
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout
end
