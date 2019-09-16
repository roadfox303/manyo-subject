Rails.application.routes.draw do
  root  'tasks#index'
  resources :tasks do
    collection do
      get :sort
    end
  end
end
