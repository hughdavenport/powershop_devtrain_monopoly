Rails.application.routes.draw do
  resources :dice_rolls
  root 'homepage#index'
  get 'homepage/index'

  resources :users
  resources :games do
    resources :dice_rolls, only: [:create]
    resources :players
  end
end
