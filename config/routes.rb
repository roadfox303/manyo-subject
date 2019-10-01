Rails.application.routes.draw do
  root  'tasks#index'
  namespace :admin do
    resources :users do
      collection do
        post :add
        delete :remove
      end
    end
  end
  # resources :admin, only: [:new, :create, :destroy]
  resources :tasks do
    collection do
      get :sort
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  # get '*anything' => 'errors#routing_error'
end
