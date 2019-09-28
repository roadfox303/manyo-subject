Rails.application.routes.draw do
  root  'tasks#index'
  resources :tasks do
    collection do
      get :sort
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
end
