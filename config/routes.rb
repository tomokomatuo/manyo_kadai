Rails.application.routes.draw do

  resources :labels
  get 'sessions/new'
 
  root "users#new"
  resources :tasks 
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
   
   resources :users

  end
  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
end
