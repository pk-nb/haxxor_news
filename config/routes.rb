Rails.application.routes.draw do
  root to: 'articles#index'

  concern :commentable do
    resources :comments, only: [:create]
  end

  concern :votable do
    match 'upvote', to: 'votes#upvote', via: :post
    match 'downvote', to: 'votes#downvote', via: :post
  end

  resources :articles, only: [:new, :create, :show, :index], concerns: [:commentable, :votable]
  resources :comments, only: [], concerns: [:commentable, :votable]
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update], path: 'reset', as: :reset

  get 'signup', to: 'users#new', as: :signup
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout
end
