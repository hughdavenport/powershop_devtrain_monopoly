Rails.application.routes.draw do
  root 'homepage#index'
  get 'homepage/index'

  resources :users
  resources :games do
    resources :players
  end
end
