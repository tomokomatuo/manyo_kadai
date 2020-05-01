Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks do
    # get :search, on: :collection
      # get :index, on: :collection   
  end
end
