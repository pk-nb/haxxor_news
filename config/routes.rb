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
  resources :password_resets, only: [:new, :create, :edit]

  get 'signup', to: 'users#new', as: :signup
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout
  get 'reset', to: 'password_resets#new', as: :new_reset
  get 'reset/:id', to: 'password_resets#edit', as: :edit_reset

end
