Rails.application.routes.draw do
  get 'sessions/new'
  root "users#new"
  resources :tasks 
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
