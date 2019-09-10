Rails.application.routes.draw do
  resources :tasks do
    collection do
      get :sort
    end
  end
end
